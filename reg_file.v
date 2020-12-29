/*******************************************************************
*
* Module: RegFile.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the register file.

**********************************************************************/
module RegFile (
input clk, rst,
input [4:0] readreg1, readreg2, writereg,
input [31:0] writedata,
input regwrite,
output [31:0] readdata1, output [31:0] readdata2 );
reg [31:0]load = 0;
wire [31:0] Q [0:31];


genvar i;
generate
for(i = 0; i < 32; i=i+1) begin: myblock
    reg_32bit register(~clk, rst, load[i], writedata, Q[i]);
    end
endgenerate

assign readdata1 = Q[readreg1];
assign readdata2 = Q[readreg2];

always@(*) begin
load=0;
if(regwrite && writereg!=0)

    load[writereg] = 1;
end

endmodule