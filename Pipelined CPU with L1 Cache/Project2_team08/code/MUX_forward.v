module MUX_forward
(
	select_i,
	data_i,
	forward_EM_i,
	forward_MW_i,
	data_o
);

input [1:0] select_i;
input [31:0] data_i, forward_EM_i, forward_MW_i;
reg [31:0] tmp;
output [31:0] data_o;

assign data_o = tmp;

always@(*) begin
	if(select_i == 2'b00) begin
		tmp = data_i;
	end
	else if(select_i == 2'b10) begin
		tmp = forward_EM_i;
	end
	else begin
		tmp = forward_MW_i;
	end
end

endmodule
