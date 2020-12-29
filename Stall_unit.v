`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 07:07:38 PM
// Design Name: 
// Module Name: Stall_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Stall_unit(input [4:0] IF_ID_RegisterRs1,
IF_ID_RegisterRs2, ID_EX_RegisterRd, input ID_EX_MemRead, output reg stall);

always@(*)
begin
if (((IF_ID_RegisterRs1==ID_EX_RegisterRd)||(IF_ID_RegisterRs2==ID_EX_RegisterRd) ) && ID_EX_MemRead && (ID_EX_RegisterRd !=0))
stall = 1;
else
stall=0;
end

endmodule