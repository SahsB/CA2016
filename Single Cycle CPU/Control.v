module Control
(
	Op_i,
	RegDst_o,
	ALUOp_o,
	ALUSrc_o,
	RegWrite_o
);

input [5:0] Op_i;
output RegDst_o, ALUSrc_o, RegWrite_o;
output [1:0] ALUOp_o;
reg tmpRegDst, tmpALUSrc;
reg [1:0] tmpALUOp;

assign RegDst_o = tmpRegDst;
assign ALUOp_o = tmpALUOp;
assign ALUSrc_o = tmpALUSrc;
assign RegWrite_o = 1'd1;

always@(*) begin
	if(Op_i[3]) begin
		tmpRegDst = 1'd1;
		tmpALUOp = 2'd0;
		tmpALUSrc = 1'd1;
	end
	else begin
		tmpRegDst = 1'd0;
		tmpALUOp = 2'd3;
		tmpALUSrc = 1'd0;
	end
end

endmodule
