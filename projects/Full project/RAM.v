module RAM #(parameter width = 20 , parameter address = 8 , parameter depth =256 )(
input clk,
input rst_n,
input wr,
input rd,
input [width-1 : 0 ] din ,
input [width-1 : 0 ] addr ,

output reg [width-1 : 0] dout ,
output reg valid 

);
reg [width-1:0] mem [depth-1:0];
integer i ;


always @ (posedge clk or negedge rst_n) begin

if(~rst_n)begin 

for (i=0 ; i < depth ; i = i+1 ) begin
mem[i] <= 'b0;
end
end

else if (wr)  begin
 
 mem [address] <= din ;
 
end
 else if(rd) begin 
 
 dout <= mem [address]  ;
 valid <= 1'b1;
 end
 else 
 valid <= 1'b0;
end

endmodule