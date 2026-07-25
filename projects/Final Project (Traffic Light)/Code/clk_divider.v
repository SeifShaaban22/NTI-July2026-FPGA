module CLK_DIV (
    input wire CLK_F,
    input wire CLK_RST,
    output reg CLK_S
);

reg [14:0] counter;
always @(posedge CLK_F or negedge CLK_RST) begin
  if(!CLK_RST) begin 
    counter <= 15'b0;
    CLK_S <= 1'b0;
  end
  else if (counter < 25000) begin
    counter <= counter + 1;
  end
  else begin
    counter <= 15'd0;
    CLK_S <= ~ CLK_S; 
  end
end
endmodule
