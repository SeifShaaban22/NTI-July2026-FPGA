module Top (
    input  wire CLK_F, RST, Button, CLK_RST,
    input  wire [1:0] Emg, EmptySensor,
    output wire [2:0] N, S, E, W,
    output wire [6:0] segment_in0, segment_in1
);

wire [3:0] dec_input;
wire flag, CLK_S;
wire [1:0] State_cnt;
wire out_button;


// Clock Divider
CLK_DIV CLK_DIV (
    .CLK_F(CLK_F),
    .CLK_RST(CLK_RST),
    .CLK_S(CLK_S)
);


// Counter
Counter Counter (
    .CLK_S(CLK_S),
    .RST(RST),
    .Button(out_button),
    .Emg(Emg),
    .EmptySensor(EmptySensor),
    .State_cnt(State_cnt),
    .flag(flag),
    .dec_input(dec_input)
);


 // Debounce
debouncer debounce (
  .i_clk(CLK_F), 
  .i_rst(RST), 
  .i_button(Button),
  .o_synchronized_button(out_button)) ;


// FSM
FSM FSM (
    .CLK_S(CLK_S),
    .RST(RST),
    .flag(flag),
    .Emg(Emg),
    .EmptySensor(EmptySensor),
    .State_cnt(State_cnt),
    .N(N),
    .S(S),
    .E(E),
    .W(W)
);


// Seven Segment Decoder
Decoder dec0 (
    .dec_input((dec_input<=4'd9)?dec_input:dec_input-4'd10),
    .rst(RST),
    .emg(Emg),
    .segment_in(segment_in0)
);

Decoder dec1 (
    .dec_input((dec_input>4'd9)?4'd1:4'd0),
    .rst(RST),
    .emg(Emg),
    .segment_in(segment_in1)
);

endmodule
