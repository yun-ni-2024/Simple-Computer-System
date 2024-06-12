`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/11 11:31:38
// Design Name: 
// Module Name: vga_sim
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


module vga_sim();
    reg clk;
    reg [15:0] SW;
    wire [15:0] LED;
    wire [7:0] AN;
    wire [7:0] HEX;
    reg  BTNC;
    reg  PS2_CLK;
    reg  PS2_DATA;
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;
    wire  VGA_HS;
    wire  VGA_VS;
    
    wire Valid;
    
//    wire x;
//    wire y;
    vga sim(clk, SW, LED, AN, HEX, BTNC, PS2_CLK, PS2_DATA, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, Valid);
    always
        # 5 clk=~clk;
    initial begin
        clk = 1'b0;
        BTNC = 1'b0;
    end
endmodule
