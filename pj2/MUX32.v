module MUX32
(
	data1_i,
	data2_i,
	select_i,
	data_o
);

input [31:0] data1_i, data2_i;
input select_i;
reg [31:0] tmp;
output [31:0] data_o;

assign data_o = tmp;

always@(*) begin
	if(select_i) begin
		tmp = data2_i;
	end
	else begin
		tmp = data1_i;
	end
end

endmodule
