module multiplexor #(parameter WIDTH = 5 )(
input [WIDTH-1 : 0] in0 ,
input [WIDTH-1 : 0] in1 ,
input sel ,
output reg [WIDTH-1 : 0 ] mux_out );
always @ (*) begin 
case (sel) 
 'b0 : mux_out = in0;
 'b1 : mux_out = in1;
 default mux_out = 0;
endcase
end
endmodule 