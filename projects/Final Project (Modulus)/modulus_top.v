
module modulus_top
#(parameter N = 8)
(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         start,
    input  wire [N-1:0] dividend,  // the number that we divide and will be the quotient... (remainder is output; quotient not exposed - see docs)
    input  wire [N-1:0] divisor,   // the number that we divide by
    output wire [N-1:0] remainder,
    output wire         done,
    output wire         error
);

    wire         w_load;
    wire         w_en;
    wire         w_sel;
    wire         w_LSB;
    wire         w_MSB;
    wire [N:0]   w_r_shift;     // NOTE: N+1 bits now - guard bit for correct sign detection
    wire [N-1:0] w_q_shift;
    wire [N:0]   w_shifted_r;   // R:Q shifted left by 1, BEFORE the subtract/restore decision
    wire [N:0]   w_result;      // w_shifted_r - divisor (trial subtraction)
    wire [N:0]   w_mux_out;     // this cycle's resolved R value (restore or keep)
    wire         w_sub_sel = 1'b1;
    wire         w_zero_flag;
    wire [N:0]   w_divisor_ext;

    assign w_zero_flag   = (divisor == 'b0);
    assign remainder     = w_r_shift[N-1:0];
    assign w_divisor_ext = {1'b0, divisor};

    // Shift R:Q left by one bit BEFORE subtracting, per the standard
    // restoring-division algorithm (see documentation for why doing
    // subtract-then-shift, as in the original file, is wrong).
    assign w_shifted_r = {w_r_shift[N-1:0], w_q_shift[N-1]};


    control_unit_fsm #(.N(N)) fsm(
        .clk         (clk),
        .rst_n       (rst_n),
        .start       (start),
        .sub_sign    (w_MSB),
        .load        (w_load),
        .zero_flag   (w_zero_flag),
        .shift_en    (w_en),
        .sel_restore (w_sel),
        .q0_bit      (w_LSB),
        .done        (done),
        .error       (error)
    );


    shift_reg_mod #(.N(N)) reg1(
        .clk        (clk),
        .rst_n      (rst_n),
        .load       (w_load),
        .shift_en   (w_en),
        .q_in       (w_LSB),
        .R          (w_mux_out),
        .Q          (w_q_shift),
        .divide_in  (dividend),
        .R_shift    (w_r_shift),
        .Q_shift    (w_q_shift)
    );


    add_sub_mod #(.N(N+1)) addsub(
        .R          (w_shifted_r),
        .M          (w_divisor_ext),
        .sel        (w_sub_sel),
        .MSB        (w_MSB),
        .out_result (w_result)
    );


    mux_2x1_mod #(.N(N+1)) mux1(
        .r_res      (w_shifted_r),   // restore: keep the shifted value, undo the subtract
        .r_no_res   (w_result),      // no restore: keep the subtracted value
        .s          (w_sel),
        .R          (w_mux_out)
    );

endmodule
