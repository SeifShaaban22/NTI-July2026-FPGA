module RAM #(parameter width = 8 , parameter address = 5 , parameter depth = 32 )(
input clk,
input wr,
input rd,
input [address-1 : 0 ] addr ,
inout wire [width-1 : 0] data ;

);
reg [width-1:0] mem [depth-1:0];

assign  data = (rd) ? mem [address] : {width{1'bz}} ;
always @ (posedge clk ) begin

if (wr)  begin
 mem[addr] <= data ;
end

 
 
end

endmodule