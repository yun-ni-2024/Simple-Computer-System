`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 14:23:18
// Design Name: 
// Module Name: Adder8
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


module Adder8(
    input [7:0] x, y,
    input sub,
    output [7:0] f,
    output cout
    );
    wire [8:0] c;
    assign c[0] = sub;
    wire [7:0] f1;
    wire c0, c1;
    CLA8 cla1(x[7:0], y[7:0], c[0], f1[7:0], c0);
    wire [7:0] f2;
    CLA8 cla2(x[7:0], ~y[7:0], c[0], f2[7:0], c1);
    assign f = (sub == 0) ? f1 : f2;
    assign c[8] = c0;
    assign cout = c0;
endmodule
