module mux_2x1_mod
#(parameter N = 8)
(
input wire [N-1:0] r_res, r_no_res,
input wire s,
output wire [N-1:0] R 
);

assign R = (s) ? r_res : r_no_res;

endmodule
