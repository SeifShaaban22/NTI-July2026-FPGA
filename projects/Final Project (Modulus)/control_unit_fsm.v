//======================================================================
// control_unit_fsm.v  (CORRECTED)
//
// Restoring-division control FSM.
// Ports now match the instantiation in modulus_top.v exactly
// (rst_n, zero_flag, error added; write_a removed - no longer needed
// now that SHIFT and CHECK are merged into one state, see docs).
//======================================================================
module control_unit_fsm
#(parameter N = 8)
(
    input  wire clk,
    input  wire rst_n,       // async active-LOW reset (matches shift_reg_mod)
    input  wire start,
    input  wire sub_sign,    // MSB of the trial subtraction this cycle (1 = negative -> restore)
    input  wire zero_flag,   // divisor == 0
    output reg  load,
    output reg  shift_en,
    output reg  sel_restore,
    output reg  q0_bit,
    output reg  done,
    output reg  error
);

    localparam IDLE      = 2'b00;
    localparam INIT      = 2'b01;
    localparam SHIFT_SUB = 2'b10;   // shift + subtract/restore decision, ONE state, ONE clock per bit
    localparam DONE      = 2'b11;

    localparam CNT_W = (N <= 1) ? 1 : $clog2(N);

    reg [1:0]      state, next_state;
    reg [CNT_W-1:0] count;
    reg             error_r;

    //------------------------------------------------------------
    // State + counter + latched error register
    //------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= IDLE;
            count   <= {CNT_W{1'b0}};
            error_r <= 1'b0;
        end else begin
            state <= next_state;

            if (state == IDLE && start)
                error_r <= zero_flag;          // latch error decision when the op is kicked off

            if (state == INIT)
                count <= {CNT_W{1'b0}};
            else if (state == SHIFT_SUB)
                count <= count + 1'b1;
        end
    end

    //------------------------------------------------------------
    // Next-state logic
    //------------------------------------------------------------
    always @(*) begin
        case (state)
            IDLE:      next_state = start ? (zero_flag ? DONE : INIT) : IDLE;
            INIT:      next_state = SHIFT_SUB;
            SHIFT_SUB: next_state = (count == N-1) ? DONE : SHIFT_SUB;
            DONE:      next_state = start ? DONE : IDLE;
            default:   next_state = IDLE;
        endcase
    end

    //------------------------------------------------------------
    // Output logic
    //------------------------------------------------------------
    always @(*) begin
        load        = 1'b0;
        shift_en    = 1'b0;
        sel_restore = 1'b0;
        q0_bit      = 1'b0;
        done        = 1'b0;
        error       = error_r;

        case (state)
            INIT: begin
                load = 1'b1;
            end

            SHIFT_SUB: begin
                shift_en = 1'b1;
                // sub_sign = 1  -> trial subtraction went negative -> RESTORE, quotient bit = 0
                // sub_sign = 0  -> trial subtraction stayed >= 0   -> KEEP it,  quotient bit = 1
                sel_restore = sub_sign;
                q0_bit      = ~sub_sign;
            end

            DONE: begin
                done = 1'b1;
            end
        endcase
    end

endmodule
