/*******************************************************************
*
* Module: comparator.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the comparator needed to compute the branch decision
**********************************************************************/

`timescale 1ns / 1ps

module comparator(
input [2:0] func3,
input [4:0] opcode,
input   wire [31:0] a, b,
output reg flag
    );
    
     wire cf, zf, vf, sf;
     wire [31:0] sub, op_b;       
       assign op_b = (~b);
       
       assign {cf, sub} = (a + op_b + 1'b1);
       
       assign zf = (sub == 0);
       assign sf = sub[31];
       assign vf = (a[31] ^ (op_b[31]) ^ sub[31] ^ cf);
       
           
always@(*)
       if(opcode == 5'b11011 || opcode == 5'b11001)//JAL & JALR
       flag = 1'b1;
       else
       case(func3)
       3'b000: flag = zf;
       3'b001: flag = ~zf;
       3'b100: flag = (sf!=vf);
       3'b101: flag = (sf==vf);
       3'b110: flag =~cf;
       3'b111: flag = cf;
       default:flag=0;
       endcase

endmodule
