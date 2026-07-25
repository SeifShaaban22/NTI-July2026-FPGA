`timescale 1ns/1ps

module sequence_det_tb;

    // 1. Inputs to DUT
    reg clk;
    reg reset;
    reg in;

    // 2. Output from DUT
    wire sequence;

    // 3. Instantiate the Sequence Detector
    sequence_det dut (
        .clk      (clk),
        .reset    (reset),
        .in       (in),
        .sequence (sequence)
    );

    // 4. Clock Generator (10ns Period -> 100MHz)
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // 5. Main Test Stimulus
    initial begin
        // Initialize Signals
        reset = 1'b1;
        in    = 1'b0;

        // Apply Reset
        #15;
        reset = 1'b0;
        #10;

        $display("--- Starting Sequence Detection Test ---");

        // Step a sequence of input bits on clock falling edges
        // Sequence targeted in FSM logic: 1 -> 1 -> 0 -> 1 -> 0 -> 1

        @(negedge clk) in = 1'b1; // Move to S1
        @(negedge clk) in = 1'b1; // Move to S2
        @(negedge clk) in = 1'b0; // Move to S3
        @(negedge clk) in = 1'b1; // Move to S4
        @(negedge clk) in = 1'b0; // Move to S5
        
        // This '1' at S5 should trigger sequence = 1
        @(negedge clk) in = 1'b1; 

        // Wait one clock to observe output reset/transition
        @(negedge clk) in = 1'b0;

        #20;
        $display("--- Test Finished ---");
        $finish;
    end

    // Monitor Output Changes in Console
    initial begin
        $monitor("Time=%0t ns | Reset=%b | IN=%b | State=%b | Sequence_Out=%b", 
                 $time, reset, in, dut.state, sequence);
    end

endmodule