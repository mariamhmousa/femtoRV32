/*******************************************************************
*
* Module: threebyone_MUX.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a three by one mux.

**********************************************************************/
`timescale 1ns / 1ps

module threebyone_MUX(input [31:0] A, [31:0] B, [31:0] C,input [1:0]S, output reg[31:0] r );
always @(*) begin
case(S)
2'b00: r=A;
2'b01: r=B;
2'b10: r=C;
default: r=A;
endcase
end
    
endmodule
