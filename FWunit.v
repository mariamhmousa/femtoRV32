/*******************************************************************
*
* Module: FWunit.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a forwarding unit to be instantiated twice.

**********************************************************************/

`timescale 1ns / 1ps
module FWunit(
input [4:0] ID_EX_RegisterRs1, input [4:0] ID_EX_RegisterRs2, input [4:0] EX_MEM_RegisterRd, input [4:0] MEM_WB_RegisterRd, input EX_MEM_RegWrite, input MEM_WB_RegWrite,
output reg [1:0] forwardA, output reg [1:0] forwardB
    );
    always @(*) begin
    if ( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0)&& (EX_MEM_RegisterRd == ID_EX_RegisterRs1) )
    forwardA = 2'b10;
    else
    if (( MEM_WB_RegWrite && (MEM_WB_RegisterRd !=0) && (MEM_WB_RegisterRd == ID_EX_RegisterRs1) )&& !( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0)&&(EX_MEM_RegisterRd == ID_EX_RegisterRs1)) )
    forwardA = 2'b01;
    else
    forwardA = 2'b00;
    
    if ( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0)&& (EX_MEM_RegisterRd == ID_EX_RegisterRs2) )
    forwardB = 2'b10;
    else
    if (( MEM_WB_RegWrite && (MEM_WB_RegisterRd !=0) && (MEM_WB_RegisterRd == ID_EX_RegisterRs2) )&& !( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0)&&(EX_MEM_RegisterRd == ID_EX_RegisterRs2)) )
    forwardB =2'b01;
    else
    forwardB = 2'b00;
    end
endmodule
