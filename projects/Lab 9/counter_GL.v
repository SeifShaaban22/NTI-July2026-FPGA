module dff_async_rst (
    input clk,
    input rst,
    input d,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

module counter #(
    parameter WIDTH = 5
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             load,
    input  wire             enab,
    input  wire [WIDTH-1:0] cnt_in,
    output wire [WIDTH-1:0] cnt_out
);

  
    wire [WIDTH-1:0] next_cnt;
    wire [WIDTH-1:0] d_in;
    wire [WIDTH:0]   carry;
    wire             load_bar;

 
    not g_not_load (load_bar, load);

   
    assign carry[0] = enab;

   
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : bit_stage
            
            // 1. Next Count Bit = cnt_out[i] XOR carry[i]
            xor g_xor (next_cnt[i], cnt_out[i], carry[i]);

            // 2. Next Carry = carry[i] AND cnt_out[i]
            and g_and_carry (carry[i+1], carry[i], cnt_out[i]);

            // 3. Mux Logic to select between cnt_in and next_cnt:
            // d_in = (load AND cnt_in) OR (NOT(load) AND next_cnt)
            wire w_load_in, w_count_in;
            
            and g_and_load  (w_load_in,  load,     cnt_in[i]);
            and g_and_count (w_count_in, load_bar, next_cnt[i]);
            or  g_or_d      (d_in[i],     w_load_in, w_count_in);

            // 4. D Flip-Flop Instance
            dff_async_rst dff_inst (
                .clk (clk),
                .rst (rst),
                .d   (d_in[i]),
                .q   (cnt_out[i])
            );

        end
    endgenerate

endmodule