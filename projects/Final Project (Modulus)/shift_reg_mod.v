//======================================================================
// shift_reg_mod.v  (CORRECTED)
//
// R is now N+1 bits wide (a "guard" bit). Without it, the sign check
// on R-M is unreliable for about half of all (dividend, divisor) pairs
// -- see documentation. The shifting of R now happens *before* the
// subtract/restore decision (combinationally, in modulus_top), so this
// module simply LOADS whichever value the FSM has already decided on;
// it no longer re-shifts R itself.
//======================================================================
module shift_reg_mod
#(parameter N = 8)
(
input  wire             clk, rst_n,
input  wire [N:0]       R,          // already shifted + subtract/restore-resolved value for this cycle
input  wire [N-1:0]     Q, divide_in,
input  wire             shift_en, q_in, load,
output reg  [N:0]       R_shift,
output reg  [N-1:0]     Q_shift
);

always@(posedge clk , negedge rst_n)
begin
      if(!rst_n)
         begin
             R_shift <= {(N+1){1'b0}};
             Q_shift <= {N{1'b0}};
         end

	 else if (load)
		 begin
             R_shift <= {(N+1){1'b0}};
             Q_shift <= divide_in;
         end

	 else if(shift_en)
         begin
             R_shift <= R;                       // load the resolved value directly (no re-shift)
             Q_shift <= {Q[N-2:0] , q_in};        // quotient bit shifts in normally
         end
end

endmodule
