/*******************************************************************
*
* Module: ALU_Control_Unit.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the ALU Control Unit

**********************************************************************/

`timescale 1ns / 1ps

module ALU_Control_Unit( input [1:0] ALUOp, input [3:0] func, output reg [3:0] ALU_sel );

always @(*) 
case (ALUOp)
2'b00:  //LW, AUUIPC, JALR, JAL
ALU_sel=4'b0000; //ADD
2'b01:
ALU_sel=4'b0001; //SUB
2'b10: //R-Type
case (func)
    4'b0000: ALU_sel=4'b0000; //ADD
    4'b0001: ALU_sel=4'b0001; //SUB
    4'b1110: ALU_sel=4'b0101; //AND
    4'b1100: ALU_sel=4'b0100; //OR
    4'b0100: ALU_sel=4'b1101;  //SLT
    4'b0110: ALU_sel=4'b1111; //SLTU
    4'b0010: ALU_sel=4'b1000; //SLL
    4'b1000: ALU_sel=4'b0111; //XOR
    4'b1010: ALU_sel=4'b1001; //SRL
    4'b1011: ALU_sel=4'b1010; //SRA 
    default: ALU_sel=4'b0001; //OR
    endcase
2'b11: //I-Type
case (func[3:1])
    3'b000: ALU_sel=4'b0000; //ADDI
    3'b010: ALU_sel=4'b1101; //SLTI
    3'b011: ALU_sel=4'b1111; //SLTIU
    3'b100: ALU_sel=4'b0111; //XORI
    3'b110: ALU_sel=4'b0100; //ORI
    3'b111: ALU_sel=4'b0101; //ANDI
    4'b001: ALU_sel=4'b1000; //SLLI
    4'b101:
    case (func[0])
    1'b0: ALU_sel=4'b1001; //SRLI
    1'b1: ALU_sel=4'b1010; //SRAI
    endcase
endcase
default: ALU_sel=4'b0001; //OR
endcase

endmodule
