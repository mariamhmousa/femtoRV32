`timescale 1ns / 1ps

module branching_MUX(input [31:0]A, B, input [5:0] sel, output reg[31:0] input_pc);
always @(*)
case (sel[5:1])
5'b11011: input_pc= B; //jal
5'b11001: input_pc= B; //jalr
5'b11000:input_pc=(sel[0])? B:A; //branch
default: input_pc= A; 
endcase
endmodule
