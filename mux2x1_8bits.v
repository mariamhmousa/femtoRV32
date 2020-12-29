`timescale 1ns / 1ps
module mux2x1_8bits(
input [9:0] A, [9:0] B, S, output reg [9:0] c
    );
always @(*) begin
if (S)
    c = B;
    else
    c = A;
end

endmodule
