/*******************************************************************
*
* Module: prv32_ALU.v
* Project: RISCV_Pipelines_Processor
* Author: Menna Elzahar mennaelzahar@aucegypt.edu
          Mariam Mousa  mariamhmousa@aucegypt.edu
          Salma Aly     smaly@aucegypt.edu
* Description: this module represents the ALU zupported.

**********************************************************************/

module prv32_ALU(
	input   wire [31:0] a, b,
	input   wire [4:0]  shamt,
	output  reg  [31:0] r,
	output  wire        cf, zf, vf, sf,
	input   wire [3:0]  alufn
);

    wire [31:0] add, sub, op_b;
    wire cfa, cfs;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    shifter shifter0(.a(a), .shamt(shamt), .type(alufn[1:0]),  .r(sh));
    
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            4'b00_00 : r = add;//ADD
            4'b00_01 : r = add;//SUB
            4'b00_11 : r = b;
            // logic
            4'b01_00:  r = a | b;//OR
            4'b01_01:  r = a & b;//AND
            4'b01_11:  r = a ^ b;//XOR
            // shift
            4'b10_00:  r=sh;//SLL
            4'b10_01:  r=sh;//SRL
            4'b10_10:  r=sh;//SRA
            // slt & sltu
            4'b11_01:  r = {31'b0,(sf != vf)}; //SLT
            4'b11_11:  r = {31'b0,(~cf)}; //SLTU
        endcase
    end
endmodule