`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 23:08:56
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
    output OF, SF, ZF, CF,
    output cout,
    output cout_1
    );
    wire [8:0] c;
    assign c[0] = sub;
    wire [7:0] f1;
    wire c00, c01, c10, c11;
    CRA8 cra1(x[7:0], y[7:0], c[0], f1[7:0], c00, c10);
    //CLA8 cla1(x[7:0], y[7:0], c[0], f1[7:0], c00, c10);
    wire [7:0] f2;
    CRA8 cra2(x[7:0], y[7:0], c[0], f1[7:0], c00, c10);
    //CLA8 cla2(x[7:0], ~y[7:0], c[0], f2[7:0], c01, c11);
    assign f = (sub == 0) ? f1 : f2;
    assign c[8] = c00;
    assign cout = c00;
    assign c[7] = c10;
    assign OF = c[8] ^ c[7];
    assign SF = f[7];
    assign ZF = ~(|f);
    assign CF = c[8] ^ c[0];
    assign cout_1 = c[7];
endmodule
