`timescale 1ms / 1ps

module dut_tb();

reg CLK_F = 0;
reg RST = 1;
reg CLK_RST = 1;
reg Button = 0;

reg [1:0] Emg = 2'b00;
reg [1:0] EmptySensor = 2'b00;

wire [2:0] N, S, E, W;
wire [6:0] segment_in0, segment_in1;


Top Top (
    .CLK_F(CLK_F),
    .RST(RST),
    .Button(Button),
    .CLK_RST(CLK_RST),
    .Emg(Emg),
    .EmptySensor(EmptySensor),
    .N(N),
    .S(S),
    .E(E),
    .W(W),
    .segment_in0(segment_in0),
    .segment_in1(segment_in1)
);

// 50 kHz clock (20,000 ns period)
always #0.01 CLK_F = ~CLK_F;

initial begin
    // Initial reset
    CLK_RST = 0;
    RST = 0;
    #10_000; 
    CLK_RST = 1;
    RST = 1;

    
    // Normal operation
    
    Button = 0;
    Emg = 2'b00;
    EmptySensor = 2'b00;
    
    // Wait 47 ms to observe at least 4 full state transitions 
    #47_000; 

    
    // using button
    
    Button = 1; #0.3
    Button = 0; #0.15
    Button = 1; #0.2
    Button = 0; #0.1
    
    Button = 1;

    #1500; // Hold for 15ms to bypass 10ms debouncer
    Button = 0; #0.2
    Button = 1; #0.3
    Button = 0; #0.2
    Button = 1; #0.1

    Button = 0;
    
    
    // Wait 20 ms to observe the 15ms state duration
    #20_000; 

   
    // Empty road detected
   
  
    EmptySensor = 2'b11;   // NS is empty EW green
    #5_000;  // Hold for 5ms to ensure FSM catches it
    EmptySensor = 2'b00;
    
    // Wait 15 ms to observe the state transition and recovery
    #15_000;

    
    // Emergency detected
    
    Emg = 2'b10;
    #5_000; 
    Emg = 2'b00;
    
    // Wait 15 ms to observe the system recovering from emergency
    #15_000;

    $stop;
end

endmodule