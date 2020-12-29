/*******************************************************************
*
* Module: fourbyone_MUX.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a four by one mux.

**********************************************************************/

`timescale 1ns / 1ps

module fourbyone_MUX(input [31:0] A, [31:0] B, [31:0] C, [31:0] D,input [1:0]S, output reg[31:0] r );
always @(*) begin
case(S)
2'b00: r=A; //out of WB mux
2'b01: r=B; //auipc
2'b10: r=C; //jal/jalr
2'b11: r=D; //lui
endcase
end
    
endmodule
