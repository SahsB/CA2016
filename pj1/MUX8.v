module MUX8
(
	harzard_i,
	signal_i,
	signal_o
);

input [7:0] signal_i;
input harzard_i;
output [7:0] signal_o;
reg [7:0] signal_o;

always@(*) begin
	if(!harzard_i) begin
		signal_o = 8'd0;
	end
	else begin
		signal_o = signal_i;
	end
end

endmodule
