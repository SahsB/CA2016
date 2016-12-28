module ALU_Control
(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

input [5:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;
reg [2:0] tmp;

assign ALUCtrl_o = tmp;

always@(*) begin
	if(ALUOp_i == 2'd0) begin //add
		tmp = 3'b010;
	end
	if(ALUOp_i == 2'd1) begin //sub
		tmp = 3'b110;
	end
	if(ALUOp_i == 2'd2) begin //or
		tmp = 3'b001;
	end
	else begin
		case(funct_i)
			6'b100000:	tmp = 3'b010;
			6'b100010:	tmp = 3'b110;
			6'b100100:	tmp = 3'b000;
			6'b100101:	tmp = 3'b001;
			6'b011000:	tmp = 3'b111;
		endcase
	end
end

endmodule
