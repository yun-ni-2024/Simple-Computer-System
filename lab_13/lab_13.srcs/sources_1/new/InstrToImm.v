`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:18:24
// Design Name: 
// Module Name: InstrToImm
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


module InstrToImm(
    input [31:0] instr,
    input [2:0] ExtOp,
    output reg [31:0] imm
    );
    
    always @ (*) begin
        case (ExtOp)
            3'b000: imm = {instr[31] ? 20'hfffff : 20'h00000, instr[31:20]}; //I
            3'b001: imm = {instr[31:12], 12'h000}; //U
            3'b010: imm = {instr[31] ? 20'hfffff : 20'h00000, instr[31:25], instr[11:7]}; //S
            3'b011: imm = {instr[31] ? 19'b1111111111111111111 : 19'b0000000000000000000, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; //B
            3'b100: imm = {instr[31] ? 11'b11111111111 : 11'b00000000000, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; //J
            default imm = 0;
        endcase
    end
    
endmodule
