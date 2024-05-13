module cntrK
#(
	parameter DATA_WIDTH = 8
)(
	input clk,
	input rstn,
	input sel_in,
	input en_in,
	input  logic [DATA_WIDTH-1:0] sizeY_in,
	output logic [DATA_WIDTH-1:0] k_out
);

	logic [DATA_WIDTH-1:0] mux_result;

	// ---------- SUBTRACTOR ------------ //
   subtractor_reg
   #(
      .DATA_WIDTH    (DATA_WIDTH)
   )
   conv_cntr_subtractor_reg
   (
		.clk			(clk),
		.rstn			(rstn),
		.en_in		(en_in),
		.A_i			(mux_result),
		.B_i			(1),
		.A_sub_B_o	(k_out)
   );
	

	// ---------- MUX2TO1 ------------ //
   muxNto1 
   #(
      .DATA_WIDTH   (DATA_WIDTH),
      .SEL_WIDTH    ($clog2(2))
   )
	conv_cntr_mux2to1
   (
      .sel_i    (sel_in),
      .data_i   ({
						k_out,		// sel == 1
						sizeY_in		// sel == 0
					   }),
      .data_o   (mux_result)
   );


endmodule
