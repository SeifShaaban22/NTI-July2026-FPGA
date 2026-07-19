/*
module stream_parity_gen (
    input  wire clk,         
    input  wire reset,       
    input  wire serial_in,   
    output reg  parity_out   
);
    reg [7:0] data_reg;

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


module stream_parity_gen#(parameter width = 8) (
    input  wire clk,         
    input  wire reset,       
    input  wire serial_in,   
    output reg  parity_out   
);
    wire [width:0] data_reg;
	assign data_reg[0] = serial_in;

    function even_parity_calc;
        input [width-1:0] data;
        begin
            even_parity_calc = ^data;
        end
    endfunction
	
	
    always @(posedge clk) begin
        if (reset) begin
            parity_out <= 1'b0;
        end else begin
           // data_reg   <= {data_reg[width-2:0], serial_in};
          
        parity_out <= even_parity_calc(data_reg[width:1]);
        end
    end
	
	
genvar i;
generate
for (i = 0; i < width; i = i + 1) begin 
register dut (
                .clk      (clk),
                .rst      (reset),
                .data_in  (data_reg[i]),     
                .data_out (data_reg[i+1])  );
end
endgenerate
    
endmodule

////////////////////////
