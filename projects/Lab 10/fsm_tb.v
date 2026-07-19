module fsm_tb  ;
reg  a;
reg  b;
reg  clk;
reg  reset;

wire y0;
wire yl;

fsm_2 initialization (.a      ( a      ),
	.b      ( b      ),
    .clk  ( clk  ),
    .reset ( reset ),
	.y0(y0),
	.y1(y1)
	);
	
always #5 clk = ~clk ;

/*initial begin
        // %0t بيطبع الوقت الحالي، و %b بيطبع القيمة كـ Binary
        $monitor("Time = %0t ns | Reset = %b | Inputs: a = %b, b = %b | Outputs: y0 = %b, y1 = %b ", 
                 $time, reset, a, b, y0, y1);
    end
*/
initial begin 
clk = 0;
	    a= 1'b0;
		b= 1'b0;
        reset =0;
		#10;
		reset =1;
		a = 0; b = 0;
        #10;
		a = 1; b = 0;
        #10;
		a = 0; b = 1;
        #10;
		a = 1; b = 1;
        #10;
        a = 0;
        #10;
		a = 1;
        #10;
		a = 1; b = 1;
        #10;
    $finish;
 end 
endmodule