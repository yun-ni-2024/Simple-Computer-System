`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 08:10:04
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input clk,
    input InstrMemEn, InstrMemWr,
    input [31:0] addr,
    output reg [31:0] instr
    );
    
    reg [31:0] mem[1023:0];
    
    integer i;
    initial begin
//        $readmemh("E:/vivado/lab_13/sum.hex", mem);
//        $readmemb("instructions.txt", mem);
//        for (i = 0; i < (1 << 10); i = i + 1) mem[i] = 0;
    end
    
    always @ (*) begin
        if (InstrMemEn) instr = mem[addr / 4];
    end
    
endmodule
