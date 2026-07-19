module sipo #(parameter width = 20 )(

input clk,
input rst_n,
input shift_en,
input serial_in,

output reg [width-1 : 0] parallel_out  
);



always @ (posedge clk or negedge rst_n) begin
if (~rst_n)  begin
 parallel_out <= 'b0 ;
end


else if(shift_en==1)begin 
parallel_out [width-1 : 0 ] <= { parallel_out [width-2 : 0 ] ,serial_in } ;
end

end



endmodule

