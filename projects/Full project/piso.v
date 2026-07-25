module piso #(parameter width = 20 , parameter address = 8 ) (
input clk,
input rst_n,
input [width-1 : 0 ] parallel_in ,
input en ,

output reg serial_out ,
output reg valid );

always @ (posedge clk or negedge rst_n ) begin
if (!rst_n) begin
serial_out <= 'b0 ; end
else if (en) begin 
serial_out <= {parallel_in[ width-1 ]} ;

valid <= 1'b1 ;
 end
else begin
serial_out <= 'b0;
valid <= 1'b0;
end


end
endmodule