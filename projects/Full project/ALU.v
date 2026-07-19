module ALU #(parameter width2 = 8)( input [width2-1 : 0 ] in_a  , in_b ,input [ 2:0] opcode   ,input alu_en  , output reg [width2-1 : 0] alu_out  ,output reg a_is_zero );

always @ (*) begin 
a_is_zero =  ( in_a == 0 )  ;
if ( ! alu_en ) 
alu_out  = {width2{1'b0}} ;
else  begin
case (opcode)
3'b000 : alu_out = in_a + in_b ;
3'b001 : alu_out = in_a - in_b ;
3'b010 : alu_out = in_a & in_b ;
3'b011 : alu_out = in_a ^ in_b ;
3'b100 : alu_out = in_a | in_b ;
3'b101 : alu_out = in_a  ;


default : alu_out = {width2{1'b0}} ;
endcase 
end
end


endmodule
