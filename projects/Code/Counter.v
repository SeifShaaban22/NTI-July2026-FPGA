module Counter (
    input wire CLK_S, Button, RST,
    input [1:0] Emg, EmptySensor,
    input wire [1:0] State_cnt,
    output reg flag,
    output wire [3:0] dec_input
);
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [3:0] counter;
reg [3:0] maxo;
reg button_ext;   // detect button

// making change mid state
wire [3:0] maxo_eff = button_ext ? 4'd15 : maxo;

// counter logic
always @(posedge CLK_S or negedge RST) begin
    if (!RST || Emg[1]) begin
      counter <= 4'd0;
      maxo    <= 4'd10;
    end
    else if (!flag) begin
      counter <= counter + 1;
      maxo    <= button_ext ? 4'd15 : 4'd10;
    end
    else begin
      counter <= 4'd1;
    end
end

// button logic 
always @(posedge CLK_S or negedge RST) begin
    if (!RST || Emg[1])
      button_ext <= 1'b0;
    else if (Button)
      button_ext <= 1'b1;
    else if (flag)
      button_ext <= 1'b0;   
      
end

// flag logic (states transition)
always @(*) begin
  flag = 1'b0;
  case(State_cnt)
    S0, S2 : if (counter == maxo_eff || EmptySensor[1]) flag = 1'b1;
    S1, S3 : if (counter == 4'd3) flag = 1'b1;
  endcase
end

// seven segment display logic
assign dec_input = (!State_cnt[0]) ? (maxo_eff + 1 - counter) : (4'd4 - counter);

endmodule
