module subtractor_reg 
#(
	parameter DATA_WIDTH = 8
)(
	input  logic clk,
	input  logic rstn,
	input  logic en_in,
	input  logic [DATA_WIDTH-1:0] A_i,
	input  logic [DATA_WIDTH-1:0] B_i,
	output logic [DATA_WIDTH-1:0] A_sub_B_o
);
	logic [DATA_WIDTH-1:0] sub_result;

	assign sub_result = A_i - B_i;

	always_ff @(posedge clk, negedge rstn) begin
		if (!rstn) 
			A_sub_B_o <= 0;
		else if (en_in)
			A_sub_B_o <= sub_result;
		else
			A_sub_B_o <= A_sub_B_o;
	end

endmodule  
