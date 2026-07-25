module top #(
    parameter address = 8,
    parameter width = 20,
    parameter width2  = 8
)(
    input  clk,
    input  rst_n,

    input  wr,
    input  [address-1:0] addr,
    input  [width-1:0] din,

    output [width2-1:0] alu_out,
    output a_is_zero
);

 
    wire                      en;      
    wire [width-1:0]     ram_dout;
    wire                      ram_valid;    
    wire                      serial_out;
    wire                      piso_valid;   
    wire [width-1:0]     parallel_out;

    reg  [address-1:0]     raddr;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            raddr <= {address{1'b0}};
        else if (en)
            raddr <= raddr + 1'b1;
    end

    // RAM
    RAM #(
        .address(address),
        .width(width)
    ) u_ram (
        .clk    (clk),
        .rst_n  (rst_n),
        .wr  (wr),
        .addr   (addr),
        .din    (din),
        .rd  (en),
        .dout   (ram_dout),
        .valid  (ram_valid)
    );

    // PISO
	
    piso #(
        .WIDTH      (width),
        .address (address)
    ) u_piso (
        .clk         (clk),
        .rst_n       (rst_n),
        .parallel_in (ram_dout),
        .en          (en),
        .serial_out  (serial_out),
        .valid       (piso_valid)
    );

    // SIPO
    sipo #(
        .WIDTH (width)
    ) u_sipo (
        .clk          (clk),
        .rst_n        (rst_n),
        .shift_en     (piso_valid),   
        .serial_in    (serial_out),
        .parallel_out (parallel_out)
    );

    // ALU  
    ALU #(
        .WIDTH (width2)
    ) u_alu (
        .in_a      (parallel_out[15:8]),
        .in_b      (parallel_out[7:0]),
        .opcode    (parallel_out[18:16]),
        .alu_en    (parallel_out[19]),
        .alu_out   (alu_out),
        .a_is_zero (a_is_zero)
    );

endmodule
