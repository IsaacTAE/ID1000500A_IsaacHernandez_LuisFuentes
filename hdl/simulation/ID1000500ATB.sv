`timescale 1ns/1ns

// Path to the directory with the .ipd files with the mem values
`define PATH "/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/sw/"

module ID1000500ATB();

            //----------------------------------------------------------
            //.......MANDATORY TB PARAMETERS............................
            //----------------------------------------------------------
localparam	CYCLE		    = 'd20, // Define the clock work cycle in ns (user)
            DATAWIDTH    = 'd32, // AIP BITWIDTH
            MAX_SIZE_MEM = 'd64,  // MAX MEMORY SIZE AMONG ALL AIP MEMORIES (Defined by the user)
            //------------------------------------------------------------
            //..................CONFIG VALUES.............................
            //------------------------------------------------------------           
            STATUS    = 5'd30,//Mandatory config
            IP_ID     = 5'd31,//Mandatory config
            MDATAINX  = 5'd0, // Config values defined in the CSV file
            ADATAINX	 = 5'd1,
            MDATAINY  = 5'd2,
            ADATAINY	 = 5'd3,
            MDATAOUT  = 5'd4,
            ADATAOUT	 = 5'd5,
            DCONFIG	 = 5'd6,
            ACONFIG   = 5'd7,
            //------------------------------------------------------------
            //..................PARAMETERS DEFINED BY THE USER............
            //------------------------------------------------------------
				SIZEX			 = 'd10,
				SIZEY			 = 'd5,
				SIZEZ		 = SIZEX + SIZEY - 1, 
				INT_BIT_DONE = 1'b0;
            


//AIP Interface signals
reg			 readAIP;
reg			 writeAIP;
reg			 startAIP;
reg	[4:0]  configAIP;
reg	[DATAWIDTH-1:0] dataInAIP;

wire		    intAIP;
wire	[DATAWIDTH-1:0] dataOutAIP;

reg   clk, rst_a, en_s;

//Clock source procedural block
always #(CYCLE/2) clk = !clk;


//DUT instance
ID1000500A_conv
DUT
(
    .clk		(clk),
    .rst_a		(rst_a),
    .en_s		(en_s),
    .data_in	(dataInAIP),      //different data in information types
    .data_out	(dataOutAIP),     //different data out information types
    .write		(writeAIP),       //Used for protocol to write different information types
    .read		(readAIP),        //Used for protocol to read different information types
    .start		(startAIP),       //Used to start the IP core
    .conf_dbus	(configAIP),      //Used for protocol to determine different actions types
    .int_req	(intAIP)          //Interruption request
);

//Testbench stimulus
initial
   begin
      $display($time, " << Start Simulation >>");
      
      aipReset();  
      conv_task();
      
      $display($time, " << End Simulation >>");
      $stop;      
   end

task conv_task;
   //variables   
   //Auxiliar variables
   reg [DATAWIDTH-1:0] tb_data;

   reg [DATAWIDTH-1:0] dataSetx [SIZEX-1:0];
   reg [(DATAWIDTH*SIZEX)-1:0] dataSet_packedx;

   reg [DATAWIDTH-1:0] dataSety [SIZEY-1:0];
   reg [(DATAWIDTH*SIZEY)-1:0] dataSet_packedy;

   reg [DATAWIDTH-1:0] result [SIZEZ-1:0];
   reg [(DATAWIDTH*SIZEZ)-1:0] result_packed;
   
	reg   [DATAWIDTH-1:0] readMemValues [SIZEZ-1:0];

	int filex; 
	int filey; 
	int filez;

	string command;
   integer i;
   begin
        // READ IP_ID
        getID(tb_data);
        $display ("%7T Read ID %h", $time, tb_data);
        
        // READ STATUS
        getStatus(tb_data);
        $display ("%7T Read STATUS %h", $time, tb_data);
        
        //(INTERRUPTIONS) 
        //FOR ENABLING INTERRUPTIONS
        enableINT(INT_BIT_DONE);

			// Generate random values
			command = {`PATH, "genMemValues ", "\"", `PATH, "\""};
			// $display ("%s\n",command);
			$system(command);

        
		// -------------------- MEM X -------------------//

		   $readmemh({`PATH, "memX_values.ipd"}, dataSetx, 0, SIZEX-1);
        
        //****CONVERTION TO A SINGLE ARRAY
        for (i = 0; i < SIZEX ; i=i+1) begin 
            dataSet_packedx[DATAWIDTH*i+:DATAWIDTH] = dataSetx[i]; 
        end        

        writeMem(MDATAINX, dataSet_packedx, SIZEX, 0);
        
		// -------------------- MEM Y -------------------//

		   $readmemh({`PATH, "memY_values.ipd"}, dataSety, 0, SIZEY-1);

        //****CONVERTION TO A SINGLE ARRAY
        for (i = 0; i < SIZEY ; i=i+1) begin 
            dataSet_packedy[DATAWIDTH*i+:DATAWIDTH] = dataSety[i]; 
        end        
        
        writeMem(MDATAINY, dataSet_packedy, SIZEY, 0);

		  // Calculate the values with the C model program 
			$system({`PATH, "convo"});


		// -------------- CONFIG REG -----------------//
		  tb_data[31:10] = 'd0;
        tb_data[9:5]	= SIZEY; 
        tb_data[4:0]	= SIZEX; 
        
        writeConfReg(DCONFIG,tb_data,1,0);

        // START PROCESS
        $display("%7T Sending start", $time);
        start();

        /*// (WITHOUT INTERRUPTIONS) 
        //WAIT FOR DONE FLAG WITHOUT INTERRUPTS ENABLED
        tb_data = 0;
        while (!tb_data[0]) begin//checking bit DONE
            getStatus(tb_data);
            $display("%7T Status - %08x", $time, tb_data);
            #(CYCLE*10);
        end 
        //(WITHOUT INTERRUPTIONS)*/
        
        // (INTERRUPTIONS) 
        // WAIT FOR DONE FLAG WITH INTERRUPTIONS ENABLED     
        while (intAIP) begin//checking intAIP signal
            #(CYCLE*10);
        end
        // (INTERRUPTIONS)  
        
        $display("%7T Done flag detected!", $time);
        
        // READ STATUS
        getStatus(tb_data);
        $display ("%7T Read STATUS %h", $time, tb_data);
        
        //CLEAR INT DONE FLAG
        clearINT(INT_BIT_DONE);

		  #(CYCLE*5);
        
        // READ STATUS
        getStatus(tb_data);
        $display ("%7T Read STATUS %h", $time, tb_data);     


        // READ MEM OUT
        readMem(MDATAOUT, result_packed, SIZEZ, 0);
        //*****CONVERTION TO A 2D ARRAY
        for (i = 0; i < SIZEZ ; i=i+1) begin 
            result[i]= result_packed[DATAWIDTH*i+:DATAWIDTH]; 
        end
        
		  $readmemh({`PATH, "resultValues.txt"}, readMemValues);

        $display ("\t\tHDL \t\tC \tResult");
        for (i = 0; i < SIZEZ; i=i+1) begin
            $display ("[%d] \t%h \t\t%h \t\t%s", i, result[i], readMemValues[i], (result[i] === readMemValues[i]) ? "OK" : "ERROR");
        end
        
        // DISABLE INTERRUPTIONS
        disableINT(INT_BIT_DONE);

        #(CYCLE*15);
   
   end

endtask

//*******************************************************************
//*********************AIP TASKS DEFINITION**************************
//*******************************************************************

task aipReset;
   begin
      clk		= 1'b1;
      en_s		= 1'b1;
      readAIP	= 1'b0;
      writeAIP	= 1'b0;
      startAIP	= 1'b0;
      configAIP= 5'd0;
      dataInAIP= 32'd0;
      
      rst_a		= 1'b0;	// reset is active
      #3 rst_a	= 1'b1;	// at time #n release reset
      #37;
   end
endtask


task getID;
   output [DATAWIDTH-1:0] read_ID;
      
      begin
         single_read(IP_ID,read_ID);
      end
endtask

task getStatus;
   output [DATAWIDTH-1:0] read_status;
      
      begin
         single_read(STATUS,read_status);
      end
endtask

task writeMem;
        input [                         4:0] config_value;
        input [(DATAWIDTH*MAX_SIZE_MEM)-1:0] write_data;
        input [               DATAWIDTH-1:0] length;
        input [               DATAWIDTH-1:0] offset;

      integer i;
        begin        
            //SET POINTER
            single_write(config_value+1, offset);
            
            //WRITE MEMORY
            configAIP = config_value;
            #(CYCLE)
            for(i=0; i < length ; i= i+1) begin
               dataInAIP = write_data[(i*DATAWIDTH)+:DATAWIDTH];
               writeAIP = 1'b1;
               #(CYCLE);
            end
            writeAIP = 1'b0;
            #(CYCLE);
        end
endtask

task writeConfReg;
        input [                         4:0] config_value;
        input [(DATAWIDTH*MAX_SIZE_MEM)-1:0] write_data;
        input [               DATAWIDTH-1:0] length;
        input [               DATAWIDTH-1:0] offset;
        
        integer i;
        begin        
            //SET POINTER
            single_write(config_value+1, offset);
            
            //WRITE MEMORY
            configAIP = config_value;
            #(CYCLE)
            for(i=0; i < length ; i= i+1) begin
               dataInAIP = write_data[(i*DATAWIDTH)+:DATAWIDTH];
               writeAIP = 1'b1;
               #(CYCLE);
            end
            writeAIP = 1'b0;
            #(CYCLE);
        end
endtask


task readMem;
        input [                         4:0] config_value;   
        output[(DATAWIDTH*MAX_SIZE_MEM)-1:0] read_data;     
        input [               DATAWIDTH-1:0] length;
        input [               DATAWIDTH-1:0] offset;        
        
        integer i;
        begin
            //SET POINTER
            single_write(config_value+1, offset);
        
            configAIP = config_value;
            #(CYCLE)
            for(i=0; i < length ; i= i+1) begin               
               readAIP = 1'b1;
               #(CYCLE);
               read_data[(i*DATAWIDTH)+:DATAWIDTH]=dataOutAIP;
            end
            readAIP = 1'b0;
            #(CYCLE);
        end
endtask

task enableINT;
      input [3:0] idxInt;   
      
       reg [DATAWIDTH-1:0] read_status;
       reg [7:0] mask;
       
  begin

       getStatus(read_status);
       
       mask = read_status[23:16]; //previous stored mask
       mask[idxInt] = 1'b1; //enabling INT bit

       single_write(STATUS, {8'd0,mask,16'd0});//write status reg
  end
endtask

task disableINT;
      input [3:0] idxInt;   
      
       reg [DATAWIDTH-1:0] read_status;
       reg [7:0] mask;
  begin
   
       getStatus(read_status);
       
       mask = read_status[23:16]; //previous stored mask
       mask[idxInt] = 1'b0; //disabling INT bit

       single_write(STATUS, {8'd0,mask,16'd0});//write status reg
  end
endtask

task clearINT;
      input [3:0] idxInt;   
      
       reg [DATAWIDTH-1:0] read_status;
       reg [7:0] clear_value;
       reg [7:0] mask;
    
  begin
    
       getStatus(read_status);
       
       mask = read_status[23:16]; //previous stored mask
       clear_value = 7'd1 <<  idxInt;

       single_write(STATUS, {8'd0,mask,8'd0,clear_value});//write status reg
  end
endtask

task start;
  begin
      startAIP = 1'b1;
      #(CYCLE);
      startAIP = 1'b0;
      #(CYCLE);
  end
endtask

task single_write;
        input [          4:0] config_value;
        input [DATAWIDTH-1:0] write_data;
        begin
            configAIP = config_value;
            dataInAIP = write_data;
            #(CYCLE)
            writeAIP = 1'b1;
            #(CYCLE)
            writeAIP = 1'b0;
            #(CYCLE);
        end
endtask

task single_read;
  input  [          4:0] config_value;
  output [DATAWIDTH-1:0] read_data;
  begin
      configAIP = config_value;
      #(CYCLE);
      readAIP = 1'b1;
      #(CYCLE);
      read_data = dataOutAIP;
      readAIP = 1'b0;
      #(CYCLE);
  end
endtask

endmodule
