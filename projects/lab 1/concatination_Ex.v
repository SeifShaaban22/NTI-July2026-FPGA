module messi (in1,in2,en,out,carry);
parameter w=4 ;

input [w-1:0] in1,in2;
input en;

output reg [w-1:0] out;
output reg carry;




always @ (*) begin

if(en==1)begin 
{carry,out} = in1 + in2 ;
end

else begin
{carry,out} = in1 - in2 ;
end

end

endmodule
