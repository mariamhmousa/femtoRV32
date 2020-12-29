/*******************************************************************
*
* Module: Imm_Gen.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the immidiate generator.

**********************************************************************/

`timescale 1ns / 1ps

`include "defines.v"
    
    module rv32_ImmGen (
        input  wire [31:0]  IR,
        output reg  [31:0]  Imm
    );
    
    always @(*) begin
        case (`OPCODE)
            `OPCODE_Arith_I     :   case(IR[14:12])
                        3'b000:Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };//addi
                        3'b010:Imm = { {21{IR[31]}}, IR[30:20]};//slti
                        3'b011:Imm = { {21{IR[31]}}, IR[30:20]};//sltiu
                        3'b100:Imm = { {21{IR[31]}}, IR[30:20]};//XORI
                        3'b110:Imm = { {21{IR[31]}}, IR[30:20]};//ORI
                        3'b111:Imm = { {21{IR[31]}}, IR[30:20]};//ANDI
                        3'b001:Imm = { {27{IR[31]}}, IR[24:20]};//SLLI
                        3'b101:Imm = { {27{IR[31]}}, IR[24:20]};//SRLI,SRAI
                        endcase
            `OPCODE_Store     :     Imm = { {21{IR[31]}}, IR[30:25], IR[11:8], IR[7] };
            `OPCODE_LUI       :     Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
            `OPCODE_AUIPC     :     Imm = { IR[31], IR[30:20], IR[19:12], 11'b0 };
            `OPCODE_JAL       :     Imm = { {13{IR[31]}}, IR[19:12], IR[20], IR[30:25], IR[24:21] };
            `OPCODE_JALR      :     Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };
            `OPCODE_Branch    :     Imm = { {20{IR[31]}}, IR[7], IR[30:25], IR[11:8]};//0001000
            default           :     Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] }; // IMM_I
        endcase
    end
    
    endmodule