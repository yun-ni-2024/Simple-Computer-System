`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 16:37:43
// Design Name: 
// Module Name: vga
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


module vga(
    input CLK,  
    input [15:0] SW,
    output [15:0] LED,
//    output [7:0] AN,
//    output [7:0] HEX,
    input  BTNC,
//    input  PS2_CLK,
//    input  PS2_DATA,
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output  VGA_HS,
    output  VGA_VS,
    
    output Valid,
    
    input [7:0] key_ascii,
    input [12:0] key_count,
    
    input vga_we,
    input [31:0] vga_addr, vga_datain
    );
    
wire clk;
wire clk_1m;
wire clk_25m;
wire [11:0] vga_data;
wire valid;
wire [9:0] h_addr;
wire [9:0] v_addr;

//clkgen #(1000000) my1m_clk(CLK100MHZ,SW[0],1'b1,clk_1m);
//clkgen #(25000000) my25m_clk(CLK100MHZ,SW[0],1'b1,clk_25m);
assign clk=CLK;
//clk_wiz_0 my25m_clk(.clk_in1(CLK100MHZ),.reset(SW[0]),.locked(LED[0]),.clk_out1(clk_25m));

//sevenseg my_7seg(clk_1m,8'h00, 32'h0,AN,HEX);
//seg7decimal my_7_seg(32'h0,clk_25m,HEX[6:0],AN,HEX[7]);
assign AN = 8'hff;
//assign LED=16'h0;

//wire [7:0] key_ascii;
//wire [12:0] key_count;
//inoutlab my_keyboard(clk_25m, PS2_CLK, PS2_DATA, 0, key_ascii, key_count);

vga_ctrl my_vga(clk, BTNC, h_addr, v_addr, VGA_HS, VGA_VS, valid);
vga_display my_diaplay(clk, BTNC, h_addr, v_addr, valid, vga_data, key_ascii, key_count, vga_we, vga_addr, vga_datain);
    assign VGA_R = valid?vga_data[11:8]:4'h0;
    assign VGA_G = valid?vga_data[7:4]:4'h0;
    assign VGA_B = valid?vga_data[3:0]:4'h0;
//vga_ram myram(.addra({h_addr,v_addr[8:0]}),.clka(clk),.ena(1'b1),.wea(1'b0),.dina(12'd0),.douta(vga_data));
assign Valid = valid;
endmodule
