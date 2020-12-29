`timescale 1ns / 1ps
module control_unit(
input [6:0]instr, output reg [1:0] RdSrc,
output reg Branch,  MemRead,  MemtoReg,  MemWrite, ALUSrc, RegWrite, output reg [1:0]ALUOp);

    always@(*) 
    case(instr[6:2]) 
    5'b01100:begin//R-format
        Branch =0;
        MemRead=0;
        MemtoReg=0;
        ALUOp=2'b10;
        MemWrite=0;
        ALUSrc=0;
        RegWrite=1;
        RdSrc=0;
    end
    5'b00100: begin //I-format
        Branch =0;
        MemRead=0;
        MemtoReg=0;
        ALUOp=2'b11;
        MemWrite=0;
        ALUSrc=1;
        RegWrite=1;
        RdSrc=0;
    end

    5'b00000: begin//Load 
        Branch =0;
        MemRead=1;
         MemtoReg=1;
         ALUOp=2'b00;
         MemWrite=0;
         ALUSrc=1;
         RegWrite=1;
         RdSrc=0;
        end   
    5'b01000: begin//SW
         Branch =0;
         MemRead=0;
         ALUOp=2'b00;
         MemWrite=1;
         ALUSrc=1;
         RegWrite=0;
         RdSrc=0;
        end
    5'b11000: begin//BEQ
         Branch =1;
          MemRead=0;
          //MemtoReg=0; ///X
          ALUOp=2'b01;
          MemWrite=0;
          ALUSrc=0;
          RegWrite=0;
          end
     5'b11011: begin//JAL
          Branch =1;
          MemRead=0;
          MemWrite=0;
          RegWrite=1;
          ALUSrc=0;
          RdSrc=2'b10;
          end
     5'b00101: begin//AUIPC
         Branch =0;
         MemRead=0;
         MemWrite = 0;
         RegWrite = 1;
        RdSrc=2'b01;
        end
     5'b11001: begin//JALR
            Branch = 1;
            MemRead=0;
            MemtoReg=0;
            ALUOp=2'b00;
            MemWrite=0;
            ALUSrc=1;
            RegWrite=1;
            RdSrc=2'b10;
        end
      5'b01101: begin //LUI
              Branch =0;
              MemRead=0;
              MemtoReg=0;
              MemWrite=0;
              RegWrite=1;
              RdSrc=2'b11;    
              end
        5'b11100  : begin // ECALL,Ebreak
                   Branch =0;
                   MemRead=0;
                   ALUOp=2'b00;
                   MemWrite=0;
                   ALUSrc=0;
                   RegWrite=0;
                   MemtoReg=0;
                   RdSrc=2'b00;
                   end
           5'b00011  : begin //Fence
           Branch =0;
           MemRead=0;
           ALUOp=2'b00;
           MemWrite=0;
           ALUSrc=0;
           RegWrite=0;
          MemtoReg=0;
          RdSrc=2'b00;
           end
    default: begin
     Branch =0;
     MemRead=0;
     ALUOp=2'b00;
     MemWrite=0;
     ALUSrc=0;
     RegWrite=0;
     RdSrc=2'b00;
     end
    endcase
endmodule
