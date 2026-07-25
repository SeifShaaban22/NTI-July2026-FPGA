module FSM (
    input  CLK_S, RST, flag,
    input [1:0] Emg, EmptySensor,
    output reg [2:0] N, S, E, W,
    output  [1:0] State_cnt
);
// lsb is road, if 0 (n,s) if 1 (e,w) 0
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [1:0] state, next_state;
assign State_cnt = state;

// next_state logic
always @(*) begin
  if(Emg[1])
  begin
    next_state=(Emg[0])?S2:S0;
  end
 // lsb is the empty road , so i want to switch to another
  else if(EmptySensor[1])
  next_state=(EmptySensor[0])?S0:S2;
else begin
  case(state)
  S0, S1, S2, S3: next_state = flag ? state + 1'b1 : state;
  default: next_state = S0;
  endcase
end
end

// state registers
always @(posedge CLK_S or negedge RST) begin
  if(!RST) begin
    state <= S0;
  end
  else begin
    state <= next_state;
  end
end

// traffic light output logic
always @(*) begin
  case(state)
  S0: begin     
    N = 3'b100; S = 3'b100;
    E = 3'b001; W = 3'b001;
  end
  S1: begin
    N =3'b010; S = 3'b010;
    E =3'b001; W = 3'b001;
  end
  S2: begin
    N =3'b001; S = 3'b001;
    E =3'b100; W = 3'b100;
  end
  S3: begin
    N =3'b001; S = 3'b001;
    E =3'b010; W = 3'b010;
  end
  default: begin
    N =3'b100; S = 3'b100;
    E =3'b001; W = 3'b001;
  end
  endcase
end
endmodule
