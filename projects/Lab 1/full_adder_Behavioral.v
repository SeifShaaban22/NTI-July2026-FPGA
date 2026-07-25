module full_adder ( input a ,input b ,input c ,output reg sum ,output reg cout );
always @(*) begin 
sum = (a ^ b) ^ c   ;
cout = (( a ^ b ) & c ) | ( a & b ) ; 



end
endmodule
/////////////////////////////////////////////////////////////
module full_adder ( input a ,input b ,input c ,output reg cout ,output reg carry )
always @(*) begin
{sum , cout } = a + b + c ;

 end 


endmodule
/////////////////////////////////////////////////////////////
