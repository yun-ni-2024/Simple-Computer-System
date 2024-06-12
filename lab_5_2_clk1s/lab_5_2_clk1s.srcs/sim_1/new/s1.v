`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/16 17:29:30
// Design Name: 
// Module Name: s1
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


module s1();
    reg clk;
    reg rst;
    wire clkout;
    wire [30:0] cnt;
    clk1s ss(clk, rst, clkout, cnt);
    always
        # 5 clk = ~clk;
    initial begin
        rst = 0;
        #5
        clk = 0; rst = 1;
        #15
        rst = 0;
    end
endmodule
