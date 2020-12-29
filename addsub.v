/*******************************************************************
*
* Module: RCA_32bit.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents as adder/subtractor.
**********************************************************************/

`timescale 1ns / 1ps

module RCA_32bit(input [31:0] x, input [31:0] y, output [31:0] Out, input k);

genvar i;
wire [32:0]cin;
wire [31:0] S;
assign cin[0]=k;

    generate
    for (i=0; i<32; i=i+1) begin: myblock
        full_adder FA(x[i], (y[i]^k  ),cin[i], S[i], cin[i+1]);
    end
    endgenerate



assign Out =  S;
endmodule