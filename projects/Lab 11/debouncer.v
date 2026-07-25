module debouncer (
input reset , clk ,sw,
output reg db
);

reg tick ;
reg [9:0]counter;

localparam [2:0] zero = 3'b000 ,
                 wait1_1 = 3'b001 ,
				 wait1_2 = 3'b010 ,
				 wait1_3 = 3'b011 ,
				 one = 3'b100 ,
				 wait0_1 = 3'b101 ,
				 wait0_2 = 3'b110 ,
				 wait0_3  = 3'b111 ;
	
reg [2:0] present_state, next_state;

always@(posedge clk or negedge reset )
    begin : State_Register 
	if(!reset)
		present_state <= zero;
		else 
	    present_state <= next_state;
	end	
	
always@(posedge clk or negedge reset )
    begin : counter_func 
	if(!reset) begin
		counter <= 10'b0;
		tick <= 1'b0;
		end
		else if (counter < 10'd999) begin
	    counter <= counter + 1 ;
		tick <= 1'b0;
		end
else begin
		counter <= 0;
		tick <= 1;
		end
	end
	
always@ *
begin 
db = 1'b0;
next_state = present_state;
case (present_state) 

zero :
begin 
if (sw) begin 
next_state = wait1_1 ;
	end
	else begin 
    next_state = zero ;
	end
end 

wait1_1 : begin
if (sw) begin 
   if (tick) 
    next_state = wait1_2 ;
   else 
    next_state = wait1_1;
   end 
 else begin 
    next_state = zero ;
 end 
 
 end
 
wait1_2 : begin
if (sw) begin 
   if (tick) 
    next_state = wait1_3 ;
   else 
    next_state = wait1_2;
   end 
 else begin 
    next_state = zero ;
 end 
 
 end
 
 wait1_3 : begin
if (sw) begin 
   if (tick) 
    next_state = one ;
   else 
    next_state = wait1_3;
   end 
 else begin 
    next_state = zero ;
 end 
 
 end
 
 one : begin
if (!sw) begin 
    next_state = wait0_1 ;
	db = 1;
end
   else 
    next_state = one;
   end 
 
 
 wait0_1 : begin
if (!sw) begin 
   if (tick) begin
    next_state = wait0_2 ;
	db = 1;
	end
   else 
    next_state = wait0_1;
   end 
 else begin 
    next_state = one ;
 end 
 
 end
 
 wait0_2 : begin
if (!sw) begin 
   if (tick) begin
    next_state = wait0_3 ;
	db = 1;
	end
   else 
    next_state = wait0_2;
   end 
 else begin 
    next_state = one ;
 end 
 
 end
 
 wait0_3 : begin
if (!sw) begin 
   if (tick) begin
    next_state = zero ;
	db = 1;
	end
   else 
    next_state = wait0_3;
   end 
 else begin 
    next_state = one ;
 end 
 
 end
 

default : next_state = zero;


endcase
end	
endmodule