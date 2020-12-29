
/*******************************************************************
*
* Module: Register.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents a register.

**********************************************************************/
`timescale 1ns / 1ps

module Register #(parameter n = 32)(
input clk,
input rst,
input load,
input [n-1:0] in,
output [n-1:0] Q
    );

genvar i;
wire [n-1:0] D;
generate
for(i = 0; i < n; i = i+1)begin: myblock
    mux_2x1 mux( Q[i], in[i], load,  D[i]);
    DFlipFlop FF( clk,  rst,  D[i],  Q[i]);
end
endgenerate

endmodule
