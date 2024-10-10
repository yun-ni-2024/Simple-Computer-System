`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 16:46:21
// Design Name: 
// Module Name: vga_ctrl
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


module vga_ctrl(
 input wire pix_clk, //像素时钟信号
 input wire pix_rst,
 output wire [9:0] pix_x, //像素在可显示区域中的位置
 output wire [9:0] pix_y,
 output wire hsync, //行、列同步信号
 output wire vsync,
 output wire pix_valid //像素可显示标记
);
//hsync800
 parameter H_Sync_Width = 96;
 parameter H_Back_Porche = 48;
 parameter H_Active_Pixels =640;
 parameter H_Front_Porch = 16;
 parameter H_Totals = 799;
 
 //vsync525
 parameter V_Sync_Width = 2;
 parameter V_Back_Porche = 33;
 parameter V_Active_Pixels =480;
 parameter V_Front_Porch = 10;
 parameter V_Totals = 524;
reg [9:0] cnt_h ;
reg [9:0] cnt_v ;
wire rgb_valid ;
 //负逻辑有效 
assign hsync = ((cnt_h >= H_Sync_Width)) ? 1'b0 : 1'b1; 
assign vsync = ((cnt_v >= V_Sync_Width)) ? 1'b0 : 1'b1;
//cnt_h，cnt_v 像素位置计数
always@(posedge pix_clk) begin
 if (cnt_h == H_Totals) begin // last pixel on line?
 cnt_h <= 0;
 cnt_v <= (cnt_v == V_Totals) ? 0 : cnt_v + 1; // last line on screen?
 end 
 else begin
 cnt_h <= cnt_h + 1;
 end
 if (pix_rst) begin
 cnt_h <= 0;
 cnt_v <= 0;
 end
end
//pix_valid=1，表示像素处于有效显示区域
assign pix_valid = (((cnt_h >= H_Sync_Width +H_Back_Porche)
 && (cnt_h <= H_Totals- H_Front_Porch))
 &&((cnt_v >= V_Sync_Width +V_Back_Porche)
&& (cnt_v <= V_Totals - V_Front_Porch)))
 ? 1'b1 : 1'b1;
//Hsync,Vsync active，计算像素在可显示区域的位置
 assign pix_x = (pix_valid==1) ? (cnt_h - (H_Sync_Width +H_Back_Porche)):10'h3ff;
 assign pix_y = (pix_valid==1) ? (cnt_v - (V_Sync_Width+V_Back_Porche)):10'h3ff;
endmodule
