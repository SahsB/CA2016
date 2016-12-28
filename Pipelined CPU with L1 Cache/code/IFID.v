module IFID
(
    clk_i,
	flush_i,
	hazard_i,
    pc_i,
	inst_i,
	halt_i,
    pc_o,
	inst_o
);

// Ports
input               clk_i;
input               flush_i;
input               hazard_i;
input   [31:0]      pc_i;
input	[31:0]		inst_i;
input				halt_i;
output  [31:0]      pc_o;
output  [31:0]      inst_o;

// Wires & Registers
reg     [31:0]      pc_o;
reg     [31:0]      inst_o;

initial begin
#5
	pc_o = 0;
	inst_o = 0;
end

always@(posedge clk_i) begin
	if (flush_i && (~halt_i)) begin
		pc_o <= 0;
		inst_o <= 0;
	end
	else if(hazard_i&& (~halt_i)) begin
		pc_o <= pc_i;
		inst_o <= inst_i;
	end
	else if(halt_i) begin
		pc_o <= pc_o;
		inst_o <= inst_o;
	end
end

endmodule
