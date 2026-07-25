`timescale 1ns/1ps

module modulus_top_tb;

   
    localparam N = 8;
    localparam CLK_PERIOD = 10;

   
    reg              clk;
    reg              rst_n;
    reg              start;
    reg  [N-1:0]     dividend;
    reg  [N-1:0]     divisor;
    wire [N-1:0]     remainder;
    wire             done;
    wire             error;

  
    modulus_top #(.N(N)) dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .start     (start),
        .dividend  (dividend),
        .divisor   (divisor),
        .remainder (remainder),
        .done      (done),
        .error     (error)
    );

    
    initial clk = 1'b0;
    always #(CLK_PERIOD/2) clk = ~clk;//CLK_PERIOD = parameter = 10ns

   
    initial begin
        rst_n    = 1'b0; 
        start    = 1'b0;
        dividend = 8'd0;
        divisor  = 8'd0;

        #(CLK_PERIOD * 2); 
        rst_n = 1'b1;  
        #(CLK_PERIOD);

        // --- Test Case 1: (7 % 3 = 1) ---
        dividend = 8'd7;
        divisor  = 8'd3;
        start    = 1'b1;
        #(CLK_PERIOD);
        start    = 1'b0;

        wait(done == 1'b1);
        $display("Test 1 [7 %% 3]: Remainder = %0d, Error = %0b", remainder, error);
        #(CLK_PERIOD * 2);

        // --- Test Case 2:  (100 % 0 -> Error) ---
        dividend = 8'd100;
        divisor  = 8'd0;
        start    = 1'b1;
        #(CLK_PERIOD);
        start    = 1'b0;

        wait(done == 1'b1);
        $display("Test 2 [100 %% 0]: Remainder = %0d, Error = %0b", remainder, error);
        #(CLK_PERIOD * 2);

        // --- Test Case 3: (12 % 3 = 0) ---
       dividend = 8'd12;
        divisor  = 8'd3;
        start    = 1'b1;
        #(CLK_PERIOD);
        start    = 1'b0;

        wait(done == 1'b1);
        $display("Test 3 [12 %% 3]: Remainder = %0d, Error = %0b", remainder, error);
        #(CLK_PERIOD * 2);

    
        $display("--- Simulation Finished ---");
        $finish;
    end

endmodule