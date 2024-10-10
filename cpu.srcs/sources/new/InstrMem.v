`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 15:51:28
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
    input InstrMemEn, InstrMemWr,
    input [31:0] addr,
    output reg [31:0] instr,
    
    output [31:0] dbg_ins
    );
    
    reg [31:0] mem[2047:0];
    
    integer i;
    initial begin
        $readmemh("E:/vivado/lab_15/main.hex", mem);
//        $readmemh("E:/vivado/lab_15/test6.txt", mem);
//        $readmemh("E:/vivado/lab_13/sum.hex", mem);
//        $readmemb("instructions.txt", mem);
//        for (i = 0; i < (1 << 10); i = i + 1) mem[i] = 0;
    end
    
    always @ (*) begin
        if (InstrMemEn) instr = mem[addr / 4];
    end
    
    assign dbg_ins = mem[1];
    
endmodule
