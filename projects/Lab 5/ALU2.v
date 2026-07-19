module ALU2 #(parameter width = 8)( input [width-1 : 0 ] in_a  , in_b ,input [ 2:0] opcode , output reg [width-1 : 0] alu_out  ,output reg a_is_zero );

always @ (*) begin 
if ( ! in_a )
a_is_zero = 1'b1 ;
else  begin
case (opcode)
3'b000 : alu_out = in_a + in_b ;
3'b001 : alu_out = in_a - in_b ;
3'b010 : alu_out = in_a & in_b ;
3'b011 : alu_out = in_a ^ in_b ;
3'b100 : alu_out = in_a | in_b ;
3'b101 : alu_out = in_a  ;
default : alu_out = {width{1'b0}} ;
endcase 
end
end
endmodule
