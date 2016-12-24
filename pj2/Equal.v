module Equal
(
	data1_i,
	data2_i,
	eq_o
);

input [31:0] data1_i, data2_i;
output eq_o;
reg eq_o;

always@(*) begin
	if(data1_i == data2_i) begin
		eq_o = 1'b1;
	end
	else begin
		eq_o = 1'b0;
	end
end

endmodule
