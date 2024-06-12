`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/11 10:55:12
// Design Name: 
// Module Name: vga_display
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


module vga_display(
 input wire pix_clk ,
 input wire pix_rst ,
 input wire [9:0] pix_x ,
 input wire [9:0] pix_y ,
 input wire pix_valid, 
 output wire [11:0] pix_data,
 input [7:0] key_ascii,
 input [11:0] key_count
);
reg [18:0] ram_addr;
reg [11:0] mem_data;
reg [12:0] ascii_addr;
wire [7:0] ascii_data;
reg [9:0] point_addr;
wire point_data;
reg [31:0] clk_count;
reg [11:0] ascii_count;

parameter RED = 12'hF00,
 ORANGE = 12'hF80,
 YELLOW = 12'hFF0,
 GREEN = 12'h0F0,
 CYAN = 12'h0FF,
 BLUE = 12'h00F,
 PURPLE = 12'hF0F,
 BLACK = 12'h000,
 WHITE = 12'hFFF,
 GRAY = 12'hDDD;

reg [7:0] ascii[4095:0];
reg [127:0] point[128:0];
integer i;
initial begin
//$readmemh("E:/vivado/lab10_new/ASC16x8.txt", ascii, 0, 4095);
for (i = 0; i < 4096; i = i + 1) ascii[i] = 0;
$readmemh("E:/vivado/lab10_new/ascii16_96.txt", point, 0, 128);
clk_count = 0;
ascii_count = 0;
end

always @(posedge pix_clk) begin
clk_count <= clk_count + 1;
end

always @(posedge pix_clk) begin
if (ascii_count != key_count) begin
 if (key_ascii == 13) begin
  ascii_count <= key_count;
 end
 else if (key_ascii == 8) begin
  ascii[key_count] <= 0;
  ascii_count <= key_count;
 end
 else begin
  ascii[ascii_count] <= key_ascii;
  ascii_count <= key_count;
//  ascii[key_count + 1] <= 1;
 end
end
end

//wire [9:0] x, y;
//assign x = 640 - pix_x;
//assign y = 480 - pix_y;
always@(posedge pix_clk )
if(pix_rst == 1)
 mem_data <= 12'h000;
else
if (pix_valid==1) 
begin
// ascii_addr=((y>>4)<<6+(y>>4)<<4)+(x>>3);
// point_addr<=(y-y>>4)<<3+(x-x>>3);

// ascii_addr=(y>>4)*80+x>>3;
// point_addr=y%16*8+x%8;
 ascii_addr=(pix_y/16)*80+pix_x/8;
 point_addr=127-pix_y%16*8-pix_x%8;
// ram_addr=y*640+x;
end
else mem_data <=12'h000;

assign pix_data = (ascii_addr == ascii_count && clk_count[24] == 1) ? (point[128][point_addr]?12'hFFF:12'h000) : (point[ascii[ascii_addr]][point_addr]?12'hFFF:12'h000);
//assign pix_data=point[ascii[ascii_addr]][0]?12'h111:12'h000;
//assign pix_data=pix_y;
endmodule
