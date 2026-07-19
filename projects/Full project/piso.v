module piso #(parameter width = 20 , parameter address = 8 ) (
input clk,
input rst_n,
input [width-1 : 0 ] prl_in ,

output reg srl_out ,
output en ,
output reg valid );

always @ (posedge clk or negedge rst_n ) begin
if (!rst_n) begin
srl_out <= 'b0 ; end
else if (en) begin 
srl_out <= {prl_in[ width-1 ]} ;

valid <= 1'b1 ;
 end
else begin
srl_out <= 'b0;
valid <= 1'b0;
end


end
endmodule