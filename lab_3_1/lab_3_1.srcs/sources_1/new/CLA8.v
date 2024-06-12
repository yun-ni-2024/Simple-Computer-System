`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 22:55:29
// Design Name: 
// Module Name: CLA8
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


module CLA8(
    input [7:0] x, y,
    input cin,
    output [7:0] f,
    output cout,
    output cout_1
    );
    wire [8:0] c;
    assign c[0] = cin;
    CLA4 cla0(x[3:0], y[3:0], c[0], f[3:0], c[4], c[3]);
    CLA4 cla1(x[7:4], y[7:4], c[4], f[7:4], c[8], c[7]);
    assign cout = c[8];
    assign cout_1 = c[7];
endmodule
