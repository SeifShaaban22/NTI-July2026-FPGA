module rising_edge_det (
input level , clk ,
output moore_tick ,mealy_tick
);

localparam [1:0] zero = 2'b00 ,
                 edge = 2'b01 ,
				 one  = 2'b10 ;
	
reg [1:0] present_state, next_state;
  
always@(posedge clk)
    begin : State_Register 
	    present_state <= next_state;
	end	
	
always@ *
begin 
case (present_state) 

zero :
begin 
if (level) begin 
next_state = edge ;
	end
	else begin 
    next_state = zero ;
	end
end 

edge : begin
if (level) begin 
next_state = one ;
end 
else begin
next_state = zero;
 end 
 end 
 
one : begin
if (level) begin 
next_state = one ;
end 
else begin
next_state = zero;
 end 
 end 
 

default : next_state = zero;


endcase
end
//assign tick = present_state ;
//assign moore_tick = (present_state == edge || present_state == one);
assign moore_tick = (present_state == edge );
assign mealy_tick = (present_state == zero && level);
endmodule