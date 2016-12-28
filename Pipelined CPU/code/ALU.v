module ALU
(
	data1_i,
	data2_i,
	ALUCtrl_i,
	data_o,
	Zero_o
);

input [31:0] data1_i, data2_i;
input [2:0] ALUCtrl_i;
output [31:0] data_o;
output Zero_o;

reg [31:0] tmp;
reg tmpzero;

assign data_o = tmp;
assign Zero_o = 1'b0;

always@(*) begin
	case(ALUCtrl_i)
		3'b000:	tmp = data1_i & data2_i;
		3'b001:	tmp = data1_i | data2_i;
		3'b010:	tmp = data1_i + data2_i;
		3'b110:	tmp = data1_i - data2_i;
		3'b111:	tmp = data1_i * data2_i;
	endcase
end

endmodule
