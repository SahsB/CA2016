module OR
(
	eq_i,
	branch_i,
	select_o
);

input eq_i;
input branch_i;
output select_o;

assign select_o = eq_i | branch_i;

endmodule
