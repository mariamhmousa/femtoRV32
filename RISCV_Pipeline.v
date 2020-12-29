/*******************************************************************
*
* Module: RISCV_Pipeline.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module connects all the submodules to build the processor.

**********************************************************************/

module RISCV_pipeline (input clk, input rst, input [1:0]ledSel, input [3:0] ssdSel, output reg [7:0] DP_leds, output reg[12:0] num );

reg [0:31] counter = -1;
always @(posedge clk or posedge rst)
    if(rst)
        counter = -1;
    else
        counter = counter + 1;

wire [31:0] mem_out;
wire [31:0] Q;
wire [31:0] BOut;
wire [31:0] out_defaultAdder;
wire [31:0] input_PC;
wire [31:0] instmem_out;
wire [31:0] writeDataRF;
wire [31:0] readdata1;
wire [31:0] readdata2;
wire [31:0] gen_out;
wire [31:0] shifted_gen_out;
wire [31:0] ALU_input2;
wire [31:0] ALU_result;
wire [31:0] DataMem_out;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] RdSrc;
wire [3:0] ALU_sel;
wire [1:0] ALUOp;
wire EX_MEM_Branch;
wire stall;
wire [9:0] mux_stall_out;
wire [31:0] IF_ID_muxout;
reg load=1'b1;
wire  cf, zf, vf, sf;
wire flag;
wire [31:0] IF_ID_PC4;
wire [31:0] IF_ID_PC; 
wire [31:0] IF_ID_Inst;

wire [31:0] ID_EX_PC4;
wire [4:0] ID_EX_Inst;
wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
wire [9:0] ID_EX_Ctrl;
wire [3:0] ID_EX_Func; 
wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; 
wire [6:0] EX_MEM_ctrl_Input;

wire [1:0] EX_forwardA, ID_forwardA;
wire [1:0] EX_forwardB, ID_forwardB;
wire [31:0] muxA_out;
wire [31:0] muxB_out;

//Ex_Mem
wire [31:0] EX_MEM_PC4;
wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Imm;
wire [6:0] EX_MEM_Ctrl;
wire [4:0] EX_MEM_Rd;
wire EX_MEM_Zero;
wire [4:0] EX_MEM_Inst;
wire [3:0] EX_MEM_Func;
wire EX_MEM_cf, EX_MEM_vf, EX_MEM_sf;  

wire [4:0] MEM_WB_Inst;
wire [31:0] MEM_WB_PC4;
wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Imm;
wire [3:0] MEM_WB_Ctrl;
wire [4:0] MEM_WB_Rd;
wire [31:0] mux_WB_out;
wire [31:0] MEM_WB_BranchAddOut;
wire [31:0]mem_addr;
wire [31:0] ID_muxA_out, ID_muxB_out;



PC PC (clk, rst,( ~stall&&load),input_PC , Q);
//IF/ID
Register #(96) IF_ID (clk, rst, ~stall, {out_defaultAdder, Q,instmem_out}, {IF_ID_PC4,IF_ID_PC,IF_ID_Inst});

Stall_unit su(IF_ID_Inst[19:15], IF_ID_Inst[24:20], ID_EX_Rd, ID_EX_Ctrl[6], stall);
control_unit ctrl_unit(IF_ID_Inst[6:0], RdSrc, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp); //Branch,  MemRead,  MemtoReg,  MemWrite, ALUSrc, RegWrite, output reg [1:0]ALUOp, output reg AUIPC_flag, output reg [1:0] RdSrc
RegFile RF(clk, rst, IF_ID_Inst[19:15], IF_ID_Inst[24:20], MEM_WB_Rd, writeDataRF, MEM_WB_Ctrl[1], readdata1, readdata2 );
mux2x1_8bits mux_Stall( {RdSrc, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp}, 10'b0, (stall), mux_stall_out);
rv32_ImmGen ImmGen(IF_ID_Inst,gen_out);               

//ID/Ex
branchAdderinput BranchAdder(ID_muxA_out, gen_out, IF_ID_Inst[6:2], IF_ID_PC,BOut, 0);

comparator compa (IF_ID_Inst[14:12], IF_ID_Inst[6:2], ID_muxA_out, ID_muxB_out, flag); //branch decision here
FWunit ID_FW(IF_ID_Inst[19:15], IF_ID_Inst[24:20], EX_MEM_Rd, MEM_WB_Rd, EX_MEM_Ctrl[0], MEM_WB_Ctrl[1],ID_forwardA, ID_forwardB);

threebyone_MUX ID_mux3x1_A (readdata1, writeDataRF, EX_MEM_ALU_out, ID_forwardA, ID_muxA_out);
threebyone_MUX ID_mux3x1_B (readdata2, writeDataRF, EX_MEM_ALU_out, ID_forwardB, ID_muxB_out);
branching_MUX mux_branch(out_defaultAdder, BOut,{IF_ID_Inst[6:2],flag}, input_PC); //pc+4, jal or branch or jalr
RCA_32bit Default_Adder(Q, 4, out_defaultAdder, 0);


always@(*) begin // ecall
if((instmem_out[6:2]==5'b11100)&&(instmem_out[20]==1'b0)) 
begin 
load=1'b0;
end
end

Register #(194) ID_EX (clk,rst,1'b1, 
{IF_ID_PC4, IF_ID_Inst[6:2], mux_stall_out,
IF_ID_PC, readdata1, readdata2, gen_out, {IF_ID_Inst [14:12], IF_ID_Inst [30]}, IF_ID_Inst[19:15], IF_ID_Inst[24:20],IF_ID_Inst[11:7]}, 
{ID_EX_PC4, ID_EX_Inst, ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2, ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );

FWunit EX_FW(ID_EX_Rs1, ID_EX_Rs2, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_Ctrl[0], MEM_WB_Ctrl[1],EX_forwardA, EX_forwardB);
threebyone_MUX EX_mux3x1_A (ID_EX_RegR1, writeDataRF, EX_MEM_ALU_out, EX_forwardA, muxA_out);
threebyone_MUX EX_mux3x1_B (ID_EX_RegR2, writeDataRF, EX_MEM_ALU_out, EX_forwardB, muxB_out);

twobyoneMUX mux_RF(muxB_out, ID_EX_Imm, ID_EX_Ctrl[3], ALU_input2 );
ALU_Control_Unit ALU_ctrl( ID_EX_Ctrl[1:0], ID_EX_Func, ALU_sel );
prv32_ALU ALU(muxA_out, ALU_input2, ALU_input2 [4:0], ALU_result, cf, zf, vf, sf, ALU_sel);


Register #(186) EX_MEM (clk,rst,1'b1, {ID_EX_Ctrl[7], ID_EX_Imm, ID_EX_PC4, cf, vf, sf, ID_EX_Func, ID_EX_Inst, {ID_EX_Ctrl[9:4],ID_EX_Ctrl[2]}, BOut, zf, ALU_result, muxB_out,
ID_EX_Rd }, {EX_MEM_Branch, EX_MEM_Imm, EX_MEM_PC4, EX_MEM_cf, EX_MEM_vf, EX_MEM_sf, EX_MEM_Func, EX_MEM_Inst, EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Zero, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd} );
//MEM/WB

memory mem(clk, EX_MEM_Ctrl[3], EX_MEM_Ctrl[1],EX_MEM_Func[3:1] ,mem_addr[11:0], EX_MEM_RegR2, mem_out);
twobyoneMUX dataMux(32'b0, mem_out, counter[31], DataMem_out); //chooses mem_out if counter is odd
twobyoneMUX instrMUX(mem_out, 32'b0, counter[31], instmem_out); //chooses mem_out if counter is even



Register #(174) MEM_WB (clk,rst,1'b1, {EX_MEM_Imm, EX_MEM_BranchAddOut, EX_MEM_Inst, EX_MEM_PC4, EX_MEM_Ctrl[6:5], EX_MEM_Ctrl[0], EX_MEM_Ctrl[2],DataMem_out,EX_MEM_ALU_out,EX_MEM_Rd},
 {MEM_WB_Imm,MEM_WB_BranchAddOut, MEM_WB_Inst, MEM_WB_PC4, MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd});

//BRANCHING

twobyoneMUX mux_WB(MEM_WB_ALU_out,  MEM_WB_Mem_out,  MEM_WB_Ctrl[0], mux_WB_out);
twobyoneMUX mem_mux (Q, EX_MEM_ALU_out, counter[31], mem_addr); //chooses pc if counter even and alu_result if counter odd

fourbyone_MUX mux_RD(mux_WB_out, MEM_WB_BranchAddOut, MEM_WB_PC4,MEM_WB_Imm, MEM_WB_Ctrl[3:2], writeDataRF ); //decides value of data written to RF based on: usual wb, auipc, jal/jalr, lui


always @(*)
case (ssdSel)
4'b0000: num = Q[12:0]; 
4'b0001: num = out_defaultAdder [12:0]; 
4'b0010: num = BOut[12:0]; 
4'b0011: num = input_PC [12:0]; 
4'b0100: num = readdata1 [12:0]; 
4'b0101: num = readdata2 [12:0]; 
4'b0110: num = writeDataRF [12:0];
4'b0111: num = gen_out [12:0];
4'b1001:  num = ALU_input2 [12:0];
4'b1010:  num = ALU_result [12:0];
4'b1011:  num = DataMem_out [12:0];
4'b1100: num = instmem_out[11:7];
4'b1111: num = EX_MEM_RegR2[12:0];
endcase

always @(*)
case (ledSel)
2'b00: begin
DP_leds[0]=RegWrite;
DP_leds[1]=ALUSrc;
DP_leds[3:2]=ALUOp;
DP_leds[4]=MemRead;
DP_leds[5]=MemWrite;
DP_leds[6]=MemtoReg;
DP_leds[7]=Branch;
end   
2'b01:begin
DP_leds[3:0]=ALU_sel;
DP_leds[4]=zf;
DP_leds[5]=flag;
DP_leds[7:6]=2'b11;
end
endcase


endmodule