`timescale 1ns/1ps

module debouncer_tb;

    // 1. Inputs to DUT (reg)
    reg reset;
    reg clk;
    reg sw;

    // 2. Output from DUT (wire)
    wire db;

    // 3. Instantiate the Debouncer Module
    debouncer dut (
        .reset (reset),
        .clk   (clk),
        .sw    (sw),
        .db    (db)
    );

    // 4. Clock Generation (10ns period -> 100 MHz)
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // 5. Main Test Stimulus
    initial begin
        // Initialize Signals
        reset = 1'b0; // Active-Low Reset enabled
        sw    = 1'b0;

        // Apply Reset
        #20;
        reset = 1'b1; // Release Reset
        #20;

        // --- Scenario 1: Glitch / Bouncing on Press ---
        // Simulation of noisy button pressing
        $display("[%0t ns] Pressing button with noise...", $time);
        sw = 1'b1; #50;
        sw = 1'b0; #30;
        sw = 1'b1; #20;
        sw = 1'b0; #40;
        
        // Stable Press
        sw = 1'b1;
        $display("[%0t ns] Button is now stable HIGH. Waiting for debouncer...", $time);
        
        // Waiting long enough for counter to generate 3 ticks (3 * 1000 clocks)
        #35000;

        // --- Scenario 2: Glitch / Bouncing on Release ---
        $display("[%0t ns] Releasing button with noise...", $time);
        sw = 1'b0; #40;
        sw = 1'b1; #20;
        sw = 1'b0; #30;
        
        // Stable Release
        sw = 1'b0;
        $display("[%0t ns] Button is now stable LOW. Waiting for debouncer...", $time);
        
        #35000;

        // End Simulation
        $display("[%0t ns] Simulation Finished Successsfully!", $time);
        $finish;
    end

endmodule