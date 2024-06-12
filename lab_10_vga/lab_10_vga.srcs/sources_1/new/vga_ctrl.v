`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/24 00:38:45
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


//module vga_ctrl(
//   input           pclk,
//    input           reset,
//	 input  [11:0]   vga_data,
//    output [9:0]    h_addr,
//    output [9:0]    v_addr,
//    output          hsync,
//    output          vsync,
//	 output			  valid,
//    output [3:0]    vga_r,
//    output [3:0]    vga_g,
//    output [3:0]    vga_b
//    );

//   parameter    h_frontporch = 96;
//   parameter    h_active = 144;
//   parameter    h_backporch = 784;
//   parameter    h_total = 800;
   
//   parameter    v_frontporch = 2;
//   parameter    v_active = 35;
//   parameter    v_backporch = 515;
//   parameter    v_total = 525;
   
//   reg [9:0]    x_cnt;
//   reg [9:0]    y_cnt;

   
//   wire         h_valid;
//   wire         v_valid;
   
   
//   always @(posedge reset or posedge pclk)
//      if (reset == 1'b1)
//         x_cnt <= 1;
//      else 
//      begin
//         if (x_cnt == h_total)
//            x_cnt <= 1;
//         else
//            x_cnt <= x_cnt + 10'd1;
//      end

//   always @(posedge pclk)
//      if (reset == 1'b1)
//         y_cnt <= 1;
//      else 
//      begin
//         if (y_cnt == v_total & x_cnt == h_total)
//            y_cnt <= 1;
//         else if (x_cnt == h_total)
//            y_cnt <= y_cnt + 10'd1;
//      end
   
//   assign hsync = (x_cnt > h_frontporch);
//   assign vsync = (y_cnt > v_frontporch);
   
//   assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
//   assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch);
   
//   assign valid = h_valid & v_valid;
   
//   assign h_addr = h_valid ? (x_cnt - 10'd144) : {10{1'b0}};
//   assign v_addr = v_valid ? (y_cnt - 10'd35) : {10{1'b0}};


//    assign vga_r = valid?vga_data[11:8]:4'h0;
//    assign vga_g = valid?vga_data[7:4]:4'h0;
//    assign vga_b = valid?vga_data[3:0]:4'h0;

//endmodule

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
 ? 1'b1 : 1'b0;
//Hsync,Vsync active，计算像素在可显示区域的位置
 assign pix_x = (pix_valid==1) ? (cnt_h - (H_Sync_Width +H_Back_Porche)):10'h3ff;
 assign pix_y = (pix_valid==1) ? (cnt_v - (V_Sync_Width+V_Back_Porche)):10'h3ff;
endmodule
