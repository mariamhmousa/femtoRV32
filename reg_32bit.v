`timescale 1ns / 1ps

module reg_32bit(
input clk,
input rst,
input load,
input [31:0] in,
output [31:0] Q
    );

genvar i;
wire [31:0] D;
generate
for(i = 0; i < 32; i = i+1)begin: myblock
    mux_2x1 mux( Q[i], in[i], load,  D[i]);
    DFlipFlop FF( clk,  rst,  D[i],  Q[i]);
end
endgenerate

endmodule
