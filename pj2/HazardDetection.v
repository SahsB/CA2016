module HazardDetection(
	inst_i, 
	EXregRTaddr_i, 
	EXmemRead_i, 
	pchazard_o, 
	IFIDhazard_o, 
	mux8select_o);
input [31:0] inst_i; //instruction code from IF_ID
input [4:0] EXregRTaddr_i;
input EXmemRead_i;
output pchazard_o; // 0: has hazard, 1: no hazard
output IFIDhazard_o; // 0: has hazard, 1: no hazard
output mux8select_o; // 0: has hazard, 1: no hazard

wire RSeqEXRT;
wire RTeqEXRT;
wire hasHazard;

assign RSeqEXRT = (inst_i[25:21]==EXregRTaddr_i)? 1'b1:1'b0;
assign RTeqEXRT = (inst_i[20:16]==EXregRTaddr_i)? 1'b1:1'b0;
assign hasHazard = (RSeqEXRT | RTeqEXRT)&EXmemRead_i;
assign pchazard_o = !hasHazard;
assign IFIDhazard_o = !hasHazard;
assign mux8select_o = !hasHazard;

endmodule