module MUX1
(
	harzard_i,
	signal_i,
	signal_o
);

input signal_i;
input harzard_i;
output signal_o;
reg signal_o;

always@(*) begin
	if(harzard_i) begin
		signal_o = 1'b0;
	end
	else begin
		signal_o = signal_i;
	end
end

endmodule
