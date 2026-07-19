module counter_func #(parameter WIDTH = 5 )
(input clk,
input enab,
input load,
input rst,
input [WIDTH-1 : 0] cnt_in,

output reg [WIDTH-1 : 0] cnt_out);

function [WIDTH-1:0] count ( input [4:0] count_in , input load , enab ); begin
if (load) begin 
count = cnt_in  ;
end 

else if (enab) begin 
count = count + 1 ;
end end
endfunction  


always @ (posedge clk ) begin
if (rst)  begin
cnt_out <= 'b0 ;
end

else begin
cnt_out <= count ( cnt_in , load , enab ) ;
end

end
endmodule