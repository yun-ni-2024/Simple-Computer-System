`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 16:38:21
// Design Name: 
// Module Name: mux4to1_1
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


module mux4to1_1(
    output y,
    input a0, a1,a2,a3,
    input s0, s1
    );
    wire s0_n,s1_n;
    wire y0,y1,y2,y3;
    not (s0_n,s0);
    not(s1_n,s1);
    and(y0,s0_n,s1_n,a0);
    and(y1,s0_n,s1,a1);
    and(y2,s0,s1_n,a2);
    and(y3,s0,s1,a3);
    or(y,y0,y1,y2,y3);
endmodule


