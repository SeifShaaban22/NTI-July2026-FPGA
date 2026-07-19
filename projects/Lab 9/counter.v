module counter #(parameter WIDTH = 5 )
(input clk,
input enab,
input load,
input rst,
input [WIDTH-1 : 0] cnt_in,

output reg [WIDTH-1 : 0] cnt_out);

always @ (posedge clk ) begin
if (rst)  begin
cnt_out <= 'b0 ;
end

else if (load) begin 
cnt_out [WIDTH-1 : 0 ] <= cnt_in [WIDTH-1 : 0 ]  ;
end 

else if (enab) begin 
cnt_out <= cnt_out + 1 ;
end 

end
endmodule
