`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/30 17:05:05
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


module InstrToImm (
    input [31:0] instr,
    input [2:0] ExtOp,
    output reg [31:0] imm
);
    
    always @ (*) begin
        case (ExtOp)
            3'b000: imm = {instr[31:20]}; //I
            3'b001: imm = {instr[31:12]}; //U
            3'b010: imm = {instr[31:25], instr[11:7]}; //S
            3'b011: imm = {instr[31], instr[7], instr[30:25], instr[11:8]}; //B
            3'b100: imm = {instr[31], instr[19:12], instr[20], instr[30:21]}; //J
        endcase
    end
    
endmodule
