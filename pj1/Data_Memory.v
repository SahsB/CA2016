module Data_Memory
(
    addr_i,
    writedata_i,
    memread_i,
    memwrite_i, 
    readdata_o,
);

// Interface
input   [31:0]      addr_i;
input	[31:0]		writedata_i;
input	memread_i;
input	memwrite_i;
output  [31:0]      readdata_o;

// Data memory
reg     [31:0]     memory  [0:7]; //32Bytes

assign  readdata_o = memory[addr_i>>2];

always@ (*) begin
	if(memwrite_i)begin
		memory[addr_i>>2] = writedata_i;
	end
end

endmodule
