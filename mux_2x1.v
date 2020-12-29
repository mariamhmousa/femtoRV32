`timescale 1ns / 1ps
module mux_2x1(input A, B, S, output reg c);
always @(*) begin
if (S)
    c = B;
    else
    c = A;
end

endmodule
