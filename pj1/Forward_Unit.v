module Forward_Unit(
	EXMEM_RegWrite_i,
	EXMEM_RegisterRd_i,
	MEMWB_RegWrite_i,
	MEMWB_RegisterRd_i,
	IDEX_RegisterRs_i,
	IDEX_RegisterRt_i,
	ForwardA_o,
	ForwardB_o	
);

input [4:0] EXMEM_RegisterRd_i,	MEMWB_RegisterRd_i, IDEX_RegisterRs_i, IDEX_RegisterRt_i;
input EXMEM_RegWrite_i, MEMWB_RegWrite_i;
output [1:0] ForwardA_o, ForwardB_o;
reg [1:0] ForwardA_o, ForwardB_o;

// Forward A

always@(*)
begin
	if ( (EXMEM_RegWrite_i) && (EXMEM_RegisterRd_i != 0) && (EXMEM_RegisterRd_i == IDEX_RegisterRs_i) )  ForwardA_o = 2'b10;
	else if ( (MEMWB_RegWrite_i) && (MEMWB_RegisterRd_i != 0) && (MEMWB_RegisterRd_i == IDEX_RegisterRs_i) && (EXMEM_RegisterRd_i != IDEX_RegisterRs_i) )  ForwardA_o = 2'b01;
	else ForwardA_o = 2'b00;
end

// Forward B

always@(*)
begin
	
	if ( (MEMWB_RegWrite_i) && (MEMWB_RegisterRd_i != 0) && (MEMWB_RegisterRd_i == IDEX_RegisterRt_i) && (EXMEM_RegisterRd_i != IDEX_RegisterRt_i) )  ForwardB_o = 2'b01;
	else if ( (EXMEM_RegWrite_i) && (EXMEM_RegisterRd_i != 0) && (EXMEM_RegisterRd_i == IDEX_RegisterRt_i) )  ForwardA_o = 2'b10;
	else ForwardB_o = 2'b00;
end

endmodule
