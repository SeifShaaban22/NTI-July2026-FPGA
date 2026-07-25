`timescale 1ns/1ps

module tb_top;

    localparam address = 8;
    localparam width = 20;
    localparam width2  = 8;

    reg clk;
    reg rst_n;
    reg wr;
    reg [address-1:0] addr;
    reg [width-1:0] din;

    wire [width2-1:0] alu_out;
    wire a_is_zero;

    top #(
        .address(address),
        .width(width),
        .width2 (width2)
    ) dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .wr     (wr),
        .addr      (addr),
        .din       (din),
        .alu_out   (alu_out),
        .a_is_zero (a_is_zero)
    );

    // 100 MHz clock
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // test vector format: {alu_en, opcode[2:0], in_a[7:0], in_b[7:0]}
    // word0: ADD   5 + 3   -> alu_out = 8
    // word1: SUB   9 - 4   -> alu_out = 5
    // word2: AND   in_a=0  -> checks a_is_zero=1, alu_out = 0
    // word3: alu_en=0      -> alu_out forced to 0 regardless of opcode

    task write_word(input [address-1:0] a, input [width-1:0] d);
        begin
            @(posedge clk);
            wr_en <= 1'b1;
            addr  <= a;
            din   <= d;
            @(posedge clk);
            wr_en <= 1'b0;
        end
    endtask

    initial begin
        rst_n = 1'b0;
        wr = 1'b0;
        addr  = {address{1'b0}};
        din   = {width{1'b0}};

        // preload while rst_n is still low (piso_reg / raddr counter held in reset)
        write_word(8'd0, {1'b1, 3'b000, 8'd5,  8'd3});
        write_word(8'd1, {1'b1, 3'b001, 8'd9,  8'd4});
        write_word(8'd2, {1'b1, 3'b010, 8'd0,  8'd7});
        write_word(8'd3, {1'b0, 3'b000, 8'd6,  8'd2});

        wr_en = 1'b0;

        // release reset -> piso_reg starts fetching from raddr = 0
        @(posedge clk);
        rst_n = 1'b1;

        // let 4 words flow through the whole pipeline (RAM->PISO->SIPO->ALU)
        repeat (4 * width + 20) @(posedge clk);

        $finish;
    end

    // print alu_out / a_is_zero on every clock so you can see when each word lands
    always @(posedge clk) begin
        if (rst_n)
            $display("t=%0t  alu_out=%0d  a_is_zero=%0b", $time, alu_out, a_is_zero);
    end

endmodule
