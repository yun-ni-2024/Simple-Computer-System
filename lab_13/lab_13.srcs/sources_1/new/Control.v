`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/06 16:03:55
// Design Name: 
// Module Name: Control
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


module Control(
    input [31:0] instr,
    output reg [2:0] ExtOp,
    output reg RegWr,
    output reg ALUASrc,
    output reg [1:0] ALUBSrc,
    output reg [3:0] ALUctr,
    output reg [2:0] Branch,
    output reg MemtoReg,
    output reg MemWr,
    output reg [2:0] MemOp
    );
    
    wire [6:0] op;
    wire [2:0] func3;
    wire [6:0] func7;
    assign op = instr[6:0];
    assign func3 = instr[14:12];
    assign func7 = instr[31:25];
    
    always @ (*) begin
        case (op[6:2])
            5'b01101: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b001_1_000_0_0_xxx_x_01_1111; //lui
            5'b00101: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b001_1_000_0_0_xxx_1_01_0000; //auipc
            5'b00100: begin
                case (func3)
                    3'b000: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0000; //addi
                    3'b010: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0010; //slti
                    3'b011: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0011; //sltiu
                    3'b100: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0100; //xori
                    3'b110: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0110; //ori
                    3'b111: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0111; //andi
                    3'b001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0001; //slli
                    3'b101: begin
                        case (func7[5])
                            1'b0: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_0101; //srli
                            1'b1: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_0_0_xxx_0_01_1101; //srai
                            default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                        endcase
                    end
                    default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                endcase
            end
            5'b01100: begin
                case (func3)
                    3'b000: begin
                        case (func7[5])
                            1'b0: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0000; //add
                            1'b1: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_1000; //sub
                            default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                        endcase
                    end
                    3'b001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0001; //sll
                    3'b010: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0010; //slt
                    3'b011: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0011; //sltu
                    3'b100: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0100; //xor
                    3'b101: begin
                        case (func7[5])
                            1'b0: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0101; //srl
                            1'b1: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_1101; //sra
                            default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                        endcase
                    end
                    3'b110: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0110; //or
                    3'b111: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_1_000_0_0_xxx_0_00_0111; //and
                    default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                endcase
            end
            5'b11011: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b100_1_001_0_0_xxx_1_10_0000; //jal
            5'b11001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_010_0_0_xxx_1_10_0000; //jalr
            5'b11000: begin
                case (func3)
                    3'b000: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_100_x_0_xxx_0_00_0010; //beq
                    3'b001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_101_x_0_xxx_0_00_0010; //bne
                    3'b100: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_110_x_0_xxx_0_00_0010; //blt
                    3'b101: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_111_x_0_xxx_0_00_0010; //bge
                    3'b110: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_110_x_0_xxx_0_00_0011; //bltu
                    3'b111: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b011_0_111_x_0_xxx_0_00_0011; //bgeu
                    default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                endcase
            end
            5'b00000: begin
                case (func3)
                    3'b000: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_1_0_001_0_01_0000; //lb
                    3'b001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_1_0_010_0_01_0000; //lh
                    3'b010: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_1_0_000_0_01_0000; //lw
                    3'b100: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_1_0_101_0_01_0000; //lbu
                    3'b101: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b000_1_000_1_0_110_0_01_0000; //lhu
                    default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                endcase
            end
            5'b01000: begin
                case (func3)
                    3'b000: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b010_0_000_x_1_001_0_01_0000; //sb
                    3'b001: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b010_0_000_x_1_010_0_01_0000; //sh
                    3'b010: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'b010_0_000_x_1_000_0_01_0000; //sw
                    default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
                endcase
            end
            default: {ExtOp, RegWr, Branch, MemtoReg, MemWr, MemOp, ALUASrc, ALUBSrc, ALUctr} = 19'bxxx_x_xxx_x_x_xxx_x_xx_xxxx;
        endcase
    end
    
endmodule
