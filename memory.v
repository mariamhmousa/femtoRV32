/*******************************************************************
*
* Module: memory.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the single-ported memory.
**********************************************************************/
`timescale 1ns / 1ps
module memory(
input clk, input MemRead, input MemWrite, input [2:0] func3,
 input [11:0] addr, input [31:0] data_in, output reg [31:0] data_out
    );
    
reg [7:0] mem[0:1024];  

always @(posedge clk) 
begin
if (MemWrite && addr < 512) begin 
 if ( func3==3'b010 )
{mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}  = data_in; //SW  
 else if(func3==3'b000)
  mem[addr] = data_in[7:0];   //SB
 else if(func3==3'b001 )
 {mem[addr+1], mem[addr]} = data_in[15:0];  // data_in[15:0];  //SH /
    else {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]} = data_in; //SW  
  end
  end



always @(*) begin
if(addr > 511)
    data_out = {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]};
    else begin
    if (MemRead) begin
     case (func3)
     3'b000: data_out = {{24{mem[addr][7]}},mem[addr]};  //LB sign-extend
     3'b001: data_out = {{16{mem[addr+1][7]}},mem[addr+1],mem[addr]};  //LH sign-extend
     3'b010: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; //LW
     3'b100: data_out ={{24{1'b0}},mem[addr]};  //LBU extend with zeros
     3'b101: data_out ={{16{1'b0}},mem[addr+1],mem[addr]}; //LHU extend with zeros
     default: data_out= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; //LW
     endcase
     end
     
     else data_out=0;
    end
end



initial begin

//$readmemh("C:\\mh_mz_sa\\B_instr.mem", mem, 2048, 4095);
//$readmemh("C:\\mh_mz_sa\\shifttest.mem", mem, 2048, 4095);
//$readmemh("C:\\bonus_mh_mz_sa\\loads_stores.mem", mem, 2048, 4095);
//$readmemh("C:\\mh_mz_sa\\auipc_jal_jalr_lui.mem", mem, 2048, 4095);
//$readmemh("C:\\mh_mz_sa\\hazards.mem", mem, 2048, 4095);

$readmemh("C:\\mh_mz_sa\\EcallEbeakFence.mem", mem, 512, 1023);
{mem[3],mem[2],mem[1],mem[0]}=32'd17;
{mem[7],mem[6],mem[5],mem[4]}=32'd9;
{mem[11],mem[10],mem[9],mem[8]}=32'd25;
{mem[15],mem[14],mem[13],mem[12]}=32'd19;
{mem[23], mem[22], mem[21], mem[20]} = 32'd23;
end

endmodule
