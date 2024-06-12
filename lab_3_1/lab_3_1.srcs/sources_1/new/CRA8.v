`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 22:22:50
// Design Name: 
// Module Name: CRA8
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


module CRA8(
    input [7:0] x, y,
    input cin,
    output [7:0] f,
    output cout,
    output cout_1
    );
    wire [8:0] c;
    wire p, g;
    assign c[0] = cin;
    FA fa0(x[0], y[0], c[0], f[0], c[1], p, g);
    FA fa1(x[1], y[1], c[1], f[1], c[2], p, g);
    FA fa2(x[2], y[2], c[2], f[2], c[3], p, g);
    FA fa3(x[3], y[3], c[3], f[3], c[4], p, g);
    FA fa4(x[4], y[4], c[4], f[4], c[5], p, g);
    FA fa5(x[5], y[5], c[5], f[5], c[6], p, g);
    FA fa6(x[6], y[6], c[6], f[6], c[7], p, g);
    FA fa7(x[7], y[7], c[7], f[7], c[8], p, g);
    assign cout = c[8];
    assign cout_1 = c[7];
endmodule
