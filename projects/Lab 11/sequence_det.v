module sequence_det (
input in , clk ,
output sequence
);

localparam [2:0] S0 = 3'b000 ,
                 S1 = 3'b001 ,
				 S2  = 3'b010 ;
				 S3  = 3'b011 ;
				 S4  = 3'b100 ;
				 S5  = 3'b101 ;
	
reg [2:0] state, next_state;
  
always@(posedge clk or posedge reset )
if (reset)
 begin
 state <=0;
 end 
    begin 
	    state <= next_state;
	end	
	
always@ *
begin 
sequence = 1'b0;
case (state) 

S0 : next_state = (in) ? S1 : S0 ;
S1 : next_state = (in) ? S2 : S0 ;
S2 : next_state = (in) ? S2 : S3 ;
S3 : next_state = (in) ? S4 : S0 ;
S4 : next_state = (in) ? S2 : S5 ;

S5 : begin
if (in) begin 
sequence = 1'b1;
next_state = S1 ;
end 
else begin
next_state = S0;
 end 
 end 
 

default : next_state = S0;


endcase
end
endmodule