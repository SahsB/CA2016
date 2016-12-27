module Sign_Extend
(
	data_i,
	data_o
);

input [15:0] data_i;
output [31:0] data_o;
reg [31:0] tmp;

assign data_o = tmp;

always@(*) begin
	tmp[15:0] = data_i[15:0];
	if(data_i[15]) begin
		tmp[31:16] = 16'd65535;
	end
	else begin
		tmp[31:16] = 16'd0;
	end
end

endmodule
