/*******************************************************************
*
* Module: branchAdderinput.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the branch adder.
**********************************************************************/

`timescale 1ns / 1ps

module branchAdderinput (input [31:0] rs1, imm, input [4:0] opcode, input [31:0] y, output reg [31:0] Out, input k);

genvar i,j;
wire [32:0] cin1, cin2;
wire [31:0] S1, S2;
wire [31:0] shiftedimm = imm << 1;
assign cin1[0] = k;
assign cin2[0] = k;
    
    generate
    for (i=0; i<32; i=i+1) begin: myblock1
        full_adder FA1(shiftedimm[i], (y[i]^k  ),cin1[i], S1[i], cin1[i+1]);//JAL or Branch
    end
    endgenerate

    generate
    for (j=0; j<32; j=j+1) begin: myblock2
        full_adder FA2(imm[j], (rs1[j]^k  ),cin2[j], S2[j], cin2[j+1]);//JALR
    end
    endgenerate

always@(*)
if(opcode == 5'b11001)
    Out =  S2;//JALR
    else
    Out = S1;//JAL or Branch
endmodule