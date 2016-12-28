module Control
(
	Op_i,
	Jump_o,
	Branch_o,
	Control_o
);

input [5:0] Op_i;
output reg Jump_o, Branch_o;
output [7:0] Control_o;
reg ALUSrc;
reg MemtoReg;
reg MemWrite;
reg RegWrite;
reg MemRead;
reg RegDst;

reg [1:0] tmpALUOp;
reg temp;

assign Control_o = {RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, tmpALUOp[1:0], RegDst};



always@(*) begin
	if(Op_i == 6'b000000) begin
	RegDst = 1;
	ALUSrc = 0;
	MemtoReg = 0;
	RegWrite = 1;
	MemWrite = 0;
	Branch_o = 0;
	Jump_o = 0;
	MemRead = 0;
	end
	else if(Op_i == 6'b001000) begin //addi
	RegDst = 0;
	ALUSrc = 1;
	MemtoReg = 0;
	RegWrite = 1;
	MemWrite = 0;
	Branch_o = 0;
	Jump_o = 0;
	MemRead = 0;
	end
	else if(Op_i == 6'b100011) begin //lw
	RegDst = 0;
	ALUSrc = 1;
	MemtoReg = 1;
	RegWrite = 1;
	MemWrite = 0;
	Branch_o = 0;
	Jump_o = 0;
	MemRead = 1;	
	end
	else if(Op_i == 6'b101011) begin //sw
	RegDst = 0;
	ALUSrc = 1;
	MemtoReg = 0;
	RegWrite = 0;
	MemWrite = 1;
	Branch_o = 0;
	Jump_o = 0;
	MemRead = 0;	
	end
	else if(Op_i == 6'b000100) begin //beq
	RegDst = 0;
	ALUSrc = 0;
	MemtoReg = 0;
	RegWrite = 0;
	MemWrite = 0;
	Branch_o = 1;
	Jump_o = 0;
	MemRead = 0;	
	end
	else if(Op_i == 6'b000010) begin //j
	RegDst = 0;
	ALUSrc = 0;
	MemtoReg = 0;
	RegWrite = 0;
	MemWrite = 0;
	Branch_o = 0;
	Jump_o = 1;
	MemRead = 0;	
	end
//ALUOp
		case(Op_i)
			6'b000000: tmpALUOp = 2'b11; //R-Type
			6'b001000: tmpALUOp = 2'b00; //addi
			6'b100011: tmpALUOp = 2'b00; //lw
			6'b101011: tmpALUOp = 2'b00; //sw
			6'b000100: tmpALUOp = 2'b01; //beq
			default: tmpALUOp = 2'b00; //jump (don't care)
		endcase
end

endmodule
