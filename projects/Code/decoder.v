module Decoder (
    input wire [3:0] dec_input,
    input rst,
    input [1:0]emg,
    output reg [6:0] segment_in
);

always @(*) begin
    //segment inputs are a,b,c,d,e,f,g
    if (emg[1])
    segment_in = 7'b1001111; //E
    else if (!rst)
        segment_in = 7'b0000000;
    else begin
       case(dec_input)
  4'b0000: segment_in = 7'b1111110;
  4'b0001: segment_in = 7'b0110000;
  4'b0010: segment_in = 7'b1101101;
  4'b0011: segment_in = 7'b1111001;
  4'b0100: segment_in = 7'b0110011;
  4'b0101: segment_in = 7'b1011011;
  4'b0110: segment_in = 7'b1011111;
  4'b0111: segment_in = 7'b1110000;
  4'b1000: segment_in = 7'b1111111;
  4'b1001: segment_in = 7'b1111011;
  default: segment_in = 7'd0;
  endcase 
    end

end
endmodule
