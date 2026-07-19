module stream_parity_gen_tb ;
//1- input = reg --- output = wire   
   reg clk;         
    reg reset;      
    reg serial_in;   
    wire  parity_out ;  
//2- DUT instantiation
    stream_parity_gen initialization (.clk      ( clk      ),
	.reset      ( reset      ),
    .serial_in  ( serial_in  ),
    .parity_out ( parity_out ));
//3- generate clock


always #5 clk = ~clk ;// 
//task for loop 
task test ( input [7:0] in );
integer i ;
begin
for (i=7 ; i>=0 ; i=i-1 )begin
@(negedge clk );
serial_in = in[i] ; end 
end
endtask





//4- initial block 
initial begin 
// clock initialize 
        clk = 0;
	    serial_in = 1'b0;
        reset =1;
		#10;
		reset =0;
		/*//#10;
		serial_in = 1'b1;
		#10;
		serial_in = 1'b0;
		#10;
		serial_in = 1'b1;
		#10;
		serial_in = 1'b0;
		#10;
		serial_in = 1'b1;
		#10;
		serial_in = 1'b0;
		#10;
		serial_in = 1'b1;
		#10;
		serial_in = 1'b0;
		#10;
		serial_in = 1'b1;
		#10;
		serial_in = 1'b0;*/
		test (8'b0000_0111);
		#20;
		$display("Test passed output = %b ", parity_out );
		
        $stop ;


end
endmodule








/*
    function even_parity_calc;
        input [7:0] data;
        begin
            even_parity_calc = ^data;
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            data_reg   <= 8'b0;
            parity_out <= 1'b0;
        end else begin
            data_reg   <= {data_reg[6:0], serial_in};
          
            parity_out <= even_parity_calc({data_reg[6:0], serial_in});
        end
    end

endmodule 
*/ 