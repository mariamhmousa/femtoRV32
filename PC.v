/*******************************************************************
*
* Module: PC.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a register dedicated for the PC register
as it has a different implementation from the other registers.

**********************************************************************/

`timescale 1ns / 1ps

module PC(input clk,
input rst,
input load,
 input   [31:0]  in,
output [31:0] Q
    );
  wire [31:0] input1;
  reg signed [31:0] counter ;
  reg [1:0] refresh_counter = 0; // 2-bit counter
  wire PC_clk;
     always @(clk)
     begin
     refresh_counter <= refresh_counter + 1;
     end
     assign PC_clk = refresh_counter[1];

always @(posedge PC_clk or posedge rst)
    if(rst == 1)
    counter = 1;
    else
    counter = counter - 1;

assign input1= (counter>0)?in+508:in;
   
    genvar i;
    wire [31:0] D;
    generate
    for(i = 0; i < 32; i = i+1)begin: myblock
        mux_2x1 mux( Q[i], input1[i], load,  D[i]);
        DFlipFlop FF( PC_clk,  rst,  D[i],  Q[i]);
    end
    endgenerate
endmodule


