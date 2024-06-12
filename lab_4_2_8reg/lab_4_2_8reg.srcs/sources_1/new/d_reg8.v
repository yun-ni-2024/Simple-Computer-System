`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 19:44:17
// Design Name: 
// Module Name: d_reg8
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


module d_reg8(
    output [7:0] q,
    input [7:0] d,
    input clk, pr_l, clr_l, we
    );
    wire [7:0] qn;
    d_register r0(clk, d[0], pr_l, clr_l, we, q[0], qn[0]);
    d_register r1(clk, d[1], pr_l, clr_l, we, q[1], qn[1]);
    d_register r2(clk, d[2], pr_l, clr_l, we, q[2], qn[2]);
    d_register r3(clk, d[3], pr_l, clr_l, we, q[3], qn[3]);
    d_register r4(clk, d[4], pr_l, clr_l, we, q[4], qn[4]);
    d_register r5(clk, d[5], pr_l, clr_l, we, q[5], qn[5]);
    d_register r6(clk, d[6], pr_l, clr_l, we, q[6], qn[6]);
    d_register r7(clk, d[7], pr_l, clr_l, we, q[7], qn[7]);
endmodule
