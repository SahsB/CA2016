module IDEX
(
    clk_i,
	WB_i,
	M_i,
	EX_i,
	pc_i,
	data1_i,
	data2_i,
	signextend_i,
	rs_i,
	rt_i,
	rd_i,
	halt_i,
    WB_o,
	M_o,
	EX_o,
	data1_o,
	data2_o,
	signextend_o,
	rs_o,
	rt_o,
	rd_o
);

// Ports
input				halt_i;
input               clk_i;
input	[1:0]       WB_i;
input   [1:0]       M_i;
input   [3:0]       EX_i;
input   [31:0]      pc_i;
input   [31:0]      data1_i;
input   [31:0]      data2_i;
input   [31:0]      signextend_i;
input	[4:0]		rs_i;
input	[4:0]		rt_i;
input	[4:0]		rd_i;
input				halt_i;
output	[1:0]		WB_o;
output	[1:0]		M_o;
output	[3:0]		EX_o;
output  [31:0]      data1_o;
output  [31:0]      data2_o;
output  [31:0]      signextend_o;
output	[4:0]		rs_o;
output	[4:0]		rt_o;
output	[4:0]		rd_o;

// Wires & Registers
reg		[1:0]		WB_o;
reg		[1:0]		M_o;
reg		[3:0]		EX_o;
reg		[31:0]      data1_o;
reg		[31:0]      data2_o;
reg		[31:0]      signextend_o;
reg		[4:0]		rs_o;
reg		[4:0]		rt_o;
reg		[4:0]		rd_o;

initial begin
	#10
	WB_o = 0;
	M_o = 0;
	EX_o = 0;
	data1_o = 0;
	data2_o = 0;
	signextend_o = 0;
	rs_o = 0;
	rt_o = 0;
	rd_o = 0;
end

always@(posedge clk_i) begin
	
	if(~halt_i) begin
		WB_o <= WB_i;
		M_o <= M_i;
		EX_o <= EX_i;
		data1_o <= data1_i;
		data2_o <= data2_i;
		signextend_o <= signextend_i;
		rs_o <= rs_i;
		rt_o <= rt_i;
		rd_o <= rd_i;
	end
	else begin
		WB_o <= WB_o;
		M_o <= M_o;
		EX_o <= EX_o;
		data1_o <= data1_o;
		data2_o <= data2_o;
		signextend_o <= signextend_o;
		rs_o <= rs_o;
		rt_o <= rt_o;
		rd_o <= rd_o;
	end
end

endmodule
