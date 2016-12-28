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
reg     [7:0]     memory  [0:31]; //32Bytes

assign  readdata_o[31:24] = memory[addr_i+3];
assign  readdata_o[23:16] = memory[addr_i+2];
assign  readdata_o[15:8] = memory[addr_i+1];
assign  readdata_o[7:0] = memory[addr_i];

always@ (*) begin
	if(memwrite_i)begin
		memory[addr_i+3] = writedata_i[31:24];
		memory[addr_i+2] = writedata_i[23:16];
		memory[addr_i+1] = writedata_i[15:8];
		memory[addr_i] = writedata_i[7:0];
	end
end

endmodule
