/*******************************************************************
*
* Module: twobyoneMUX.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a two by one mux.

**********************************************************************/
`timescale 1ns / 1ps

module twobyoneMUX(
input [31:0] A, [31:0] B, input S, output [31:0] c
    );
    
    genvar i;
    generate
    for(i=0; i<32; i=i+1)begin: myblock
        mux_2x1 mux(A[i] , B[i] , S, c[i]);
        end
    endgenerate
    
endmodule
