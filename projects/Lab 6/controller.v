module controller (input zero , input [2:0] phase , opcode , output reg sel , rd , ld_ir , halt , inc_pc , ld_ac , wr , ld_pc , data_e ); 
always @(*) begin 
sel = 0 ; rd = 0 ; ld_ir = 0 ;  halt = 0 ; inc_pc = 0 ; ld_ac = 0 ; wr = 0 ; ld_pc = 0 ; data_e = 0 ;
case (phase)
3'b000  : begin sel = 1 ; end 

3'b001  : begin sel = 1 ; rd = 1 ; end 

3'b010  : begin sel = 1 ; rd = 1 ; ld_ir = 1; end 

3'b011  : begin sel = 1 ; rd = 1 ; ld_ir = 1; end 

3'b100  : begin halt = (opcode == 3'b000);  end 

3'b101  : begin rd = (opcode == 3'b010 ||opcode == 3'b011 ||opcode == 3'b100 ||opcode == 3'b101 ); end 

3'b110  : begin rd = (opcode == 3'b010 ||opcode == 3'b011 ||opcode == 3'b100 ||opcode == 3'b101 );
 inc_pc = (opcode == 3'b001 && zero); ld_pc = (opcode == 3'b111); data_e = (opcode == 3'b110); end
 
3'b111  : begin rd = (opcode == 3'b010 ||opcode == 3'b011 ||opcode == 3'b100 ||opcode == 3'b101 );
 ld_pc = (opcode == 3'b111); data_e = (opcode == 3'b110); wr = (opcode == 3'b110);
 ld_ac = (opcode == 3'b010 ||opcode == 3'b011 ||opcode == 3'b100 ||opcode == 3'b101 );   end 

endcase
end 
endmodule 