module MEMWB
(
    clk_i,
	WB_i,
	addr_i,
	data_i,
	rd_i,
	halt_i,
    WB_o,
	addr_o,
	data_o,
	rd_o
);

// Ports
input               clk_i;
input	[1:0]       WB_i;
input   [31:0]      addr_i;
input   [31:0]      data_i;
input	[4:0]		rd_i;
input				halt_i;
output	[1:0]		WB_o;
output  [31:0]      addr_o;
output  [31:0]      data_o;
output	[4:0]		rd_o;

// Wires & Registers
reg		[1:0]		WB_o;
reg		[31:0]      addr_o;
reg		[31:0]      data_o;
reg		[4:0]		rd_o;

initial begin
#20
	WB_o = 0;
	addr_o = 0;
	data_o = 0;
	rd_o = 0;
end

always@(posedge clk_i) begin
	
	if(~halt_i) begin
		WB_o <= WB_i;
		addr_o <= addr_i;
		data_o <= data_i;
		rd_o <= rd_i;
	end
	else begin
		WB_o <= WB_o;
		addr_o <= addr_o;
		data_o <= data_o;
		rd_o <= rd_o;
	end
end

endmodule
