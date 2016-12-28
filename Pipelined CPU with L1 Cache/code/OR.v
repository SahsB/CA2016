module OR
(
	jump_i,
    branch_i,
    flush_o
);

input jump_i;
input branch_i;
output flush_o;

assign flush_o = jump_i | branch_i;

endmodule
