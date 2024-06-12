`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 20:06:48
// Design Name: 
// Module Name: d_reg8file
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


module d_reg8file(
    input [7:0] busw,
    input [2:0] ra,
    input [2:0] rb,
    //input [2:0] rw, 
    input clk,
    output reg [7:0] busa,
    output reg [7:0] busb
    );
    wire [7:0] q [7:0];
    reg [7:0] d [7:0];
    wire pr_l = 1, clr_l = 1;
    reg we = 1;
    d_reg8 r0(d[0], clk, pr_l, clr_l, we, q[0]);
    d_reg8 r1(d[1], clk, pr_l, clr_l, we, q[1]);
    d_reg8 r2(d[2], clk, pr_l, clr_l, we, q[2]);
    d_reg8 r3(d[3], clk, pr_l, clr_l, we, q[3]);
    d_reg8 r4(d[4], clk, pr_l, clr_l, we, q[4]);
    d_reg8 r5(d[5], clk, pr_l, clr_l, we, q[5]);
    d_reg8 r6(d[6], clk, pr_l, clr_l, we, q[6]);
    d_reg8 r7(d[7], clk, pr_l, clr_l, we, q[7]);
    always @ (posedge clk) begin
        if (we) begin d[ra] <= busw; we <= 0; end
        else begin busa <= q[ra]; busb <= q[rb]; we <= 1; end
    end
endmodule
