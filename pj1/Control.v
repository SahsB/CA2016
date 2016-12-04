module Control
(
	Op_i,
	Jump_o,
	Branch_o,
	Control_o
);

input [5:0] Op_i;
output Jump_o, Branch_o;
output [7:0] Control_o;
wire ALUSrc;
wire MemtoReg;
wire MemWrite;
wire RegWrite;
wire MemRead;
wire RegDst;

reg [1:0] tmpALUOp;
reg temp;

assign RegDst_o = ~Op_i[0];
assign ALUSrc = Op_i[0];
assign MemtoReg = Op_i[1];
assign MemWrite = Op_i[3]&Op_i[5];
assign Branch_o = Op_i[2]&(~Op_i[0]);
assign Jump_o = (Op_i[1:0]==2'b10)? 1'b1:1'b0;
assign RegWrite = temp;
assign MemRead = (Op_i==6'b100011)? 1'b1:1'b0;

assign Control_o = {RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, tmpALUOp, RegDst};



always@(*) begin
//RegWrite
		case(Op_i)
			6'b000000: temp = 1; //R-type
			6'b001101: temp = 1; //ori
			6'b100011: temp = 1; //lw
			6'b101011: temp = 0; //sw
			6'b000100: temp = 0; //beq
			6'b000010: temp = 0; //jump
			default: temp = 0; //ignore
		endcase
//ALUOp
		case(Op_i)
			6'b000000: tmpALUOp = 2'b11; //R-Type
			6'b001101: tmpALUOp = 2'b10; //ori
			6'b100011: tmpALUOp = 2'b00; //lw
			6'b101011: tmpALUOp = 2'b00; //sw
			6'b000100: tmpALUOp = 2'b01; //beq
			default: tmpALUOp = 2'b00; //jump (don't care)
		endcase
end

endmodule
