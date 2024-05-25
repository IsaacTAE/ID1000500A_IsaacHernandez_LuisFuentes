module conv_TB;

	localparam DATA_WIDTH = 32;
	localparam ADDR_WIDTH = 5;

	logic clk;
	logic rstn;
	logic start;
	// MEMX 
	logic [DATA_WIDTH-1:0]		dataX;
	logic [ADDR_WIDTH-1:0]		sizeX;
	logic [ADDR_WIDTH-1:0]		memX_addr;
	// MEMY
	logic [DATA_WIDTH-1:0]		dataY;
	logic [ADDR_WIDTH-1:0]		sizeY;
	logic [ADDR_WIDTH-1:0]		memY_addr;
	// MEMZ
	logic [(DATA_WIDTH*2)-1:0] dataZ;
	logic [ADDR_WIDTH:0]			memZ_addr;
	logic								writeZ;

	logic busy;
	logic done;

	logic [DATA_WIDTH-1:0] configReg;

	logic [ADDR_WIDTH-1:0]		memZ_ram_o;
	
	// ----------- CONVOLUTION_COPROCESSOR ------------ //
	ID1000500A_convCore 
	#(
		.DATA_WIDTH		(DATA_WIDTH),
		.ADDR_WIDTH		(ADDR_WIDTH)
	)
	conv_DUT
	(
		.clk			(clk),
		.rstn			(rstn),
		.start		(start),

		.dataX		(dataX),
		.memX_addr	(memX_addr),

		.dataY		(dataY),
		.memY_addr	(memY_addr),

		.dataZ		(dataZ),
		.writeZ		(writeZ),
		.memZ_addr	(memZ_addr),

		.config_in	(configReg),

		.busy_out	(busy),
		.done_out	(done)
	);


	// -------------- MEMX_RAM ---------------- //
	simple_dual_port_ram_single_clk_sv
	#(
		.DATA_WIDTH		(DATA_WIDTH),
		.ADDR_WIDTH		(ADDR_WIDTH),
		.TXT_FILE		("/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/HDL/TB/memX_values.ipd")
	) 
	memX_ram
	(
		.clk				(clk),
		.write_en_i		(0),
		.write_addr_i	(0),
		.read_addr_i	(memX_addr),
		.write_data_i	(0),
		.read_data_o	(dataX)
	);


	// -------------- MEMY_RAM ---------------- //
	simple_dual_port_ram_single_clk_sv
	#(
		.DATA_WIDTH		(DATA_WIDTH),
		.ADDR_WIDTH		(ADDR_WIDTH),
		.TXT_FILE		("/home/ihc/Documents/TAE/Soc/ConvolucionadorPractica1/CodigoSV/HDL/TB/memY_values.ipd")
	) 
	memY_ram
	(
		.clk				(clk),
		.write_en_i		(0),
		.write_addr_i	(0),
		.read_addr_i	(memY_addr),
		.write_data_i	(0),
		.read_data_o	(dataY)
	);


	// -------------- MEMZ_RAM ---------------- //
	simple_dual_port_ram_single_clk_sv
	#(
		.DATA_WIDTH		(DATA_WIDTH*2),
		.ADDR_WIDTH		(ADDR_WIDTH+1),
		.TXT_FILE		("")
	) 
	memZ_ram
	(
		.clk				(clk),
		.write_en_i		(writeZ),
		.write_addr_i	(memZ_addr),
		.read_addr_i	(0),
		.write_data_i	(dataZ),
		.read_data_o	(memZ_ram_o)
	);


	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rstn = 0;
		start = 0;
		sizeX = 5'd10;
		sizeY = 5'd5;
		configReg = 'd0;
		configReg [9:5] = sizeY;
		configReg [4:0] = sizeX;
	
		@(negedge clk);

		rstn = 1;

		@(negedge clk);
		@(negedge clk);

		start = 1;

		@(negedge clk);

		start = 0;

		#20000;
		$stop;

	end

endmodule
