module add_sub_mod
#(parameter N = 8)
(
input wire [N-1:0] R, M,
input wire sel,
output wire MSB,
output reg [N-1:0] out_result
);
always@(*)
begin
       if(sel)
          begin
            out_result = R - M;
          end
       else
          begin
            out_result = R + M;
          end
end

assign MSB = out_result [N-1];

endmodule
