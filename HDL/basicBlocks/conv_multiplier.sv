module multiplier
#(
	parameter DATA_WIDTH = 8
)(
	input  logic [DATA_WIDTH-1:0]			A_i,
	input  logic [DATA_WIDTH-1:0]			B_i,
	output logic [(DATA_WIDTH*2)-1:0]	A_times_B_o
);

	assign A_times_B_o = A_i * B_i;

endmodule 
