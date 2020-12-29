`timescale 1ns / 1ps
module shifter(
input [31:0] a,
input [4:0] shamt,
input [1:0] type,
output reg [31:0] r
    );
    
    always @(*)
    case(type)
    2'b00: r = (a<<shamt); //SLL
    2'b01: r = (a>>shamt); //SRL
    2'b10: r = $signed(a)>>>shamt; //SRA
    endcase
endmodule
