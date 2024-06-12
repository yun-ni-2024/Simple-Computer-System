`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 16:46:52
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
 input [12:0] key_count,
 
 input vga_we,
 input [31:0] vga_addr,
 input [31:0] vga_datain
);
reg [18:0] ram_addr;
reg [11:0] mem_data;
reg [12:0] ascii_addr;
wire [7:0] ascii_data;
reg [9:0] point_addr;
wire point_data;
reg [31:0] clk_count;
reg [12:0] ascii_count;

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

reg [7:0] ascii[5119:0];
reg [127:0] point[130:0];
integer i;
initial begin
//$readmemh("E:/vivado/lab10_new/ASC16x8.txt", ascii, 0, 4095);
for (i = 0; i < 5120; i = i + 1) ascii[i] = 0;
$readmemh("E:/vivado/lab10_new/ascii16_96.txt", point, 0, 130);
clk_count = 0;
end

reg [8:0] start_row;
reg roll_en;
reg [31:0] clear_cnt;
reg [8:0] ans_row;
initial begin
 start_row <= 0;
 roll_en <= 0;
 clear_cnt <= 0;
 ans_row <= 10;
end

always @(posedge pix_clk) begin
clk_count <= clk_count + 1;
end

always @(posedge pix_clk) begin
if (ascii_count % 5120 != (key_count + ans_row * 80) % 5120) begin
 if (roll_en == 0 && key_count + ans_row * 80 >= 80 * 29) roll_en = 1;

// if (ans_currow != ans_row) begin
//  ascii_count <= (key_count + ans_row * 80) % 5120;
//  ans_currow <= ans_row;
//  if (roll_en) start_row <= (start_row + 1) % 64;
// end
// else
 if (key_ascii == 13) begin
  ascii_count <= (key_count + (ans_row + 1) * 80) % 5120;
  ans_row <= ans_row + 1;
  if (roll_en) start_row <= start_row == 0 ? (start_row + 1) % 64 : (start_row + 2) % 64;
 end
 else if (key_ascii == 8) begin
  ascii[(key_count + ans_row * 80) % 5120] <= 0;
  ascii_count <= (key_count + ans_row * 80) % 5120;
 end
 else begin
  ascii[ascii_count] <= key_ascii;
  ascii_count <= (key_count + ans_row * 80) % 5120;
  if (roll_en && key_count % 80 == 0) start_row <= (start_row + 1) % 64;
//  ascii[key_count + 1] <= 1;
 end
end
else if (vga_we && ascii[(ascii_count + 5120 - 80 + vga_addr) % 5120] == 0)
  ascii[(ascii_count + 5120 - 80 + vga_addr) % 5120] <= vga_datain[7:0];
else begin
 clear_cnt <= (clear_cnt + 1) % 5120;
 if (ascii_count / 80 * 80 + 319 >= 5120 && clear_cnt <= (ascii_count / 80 * 80 + 399) % 5120)
  ascii[clear_cnt] <= 0;
 else if (clear_cnt >= (ascii_count / 80 * 80 + 80) % 5120 && clear_cnt <= (ascii_count / 80 * 80 + 319) % 5120)
  ascii[clear_cnt] <= 0;
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
 ascii_addr=((pix_y/16)*80+pix_x/8 + (start_row * 80)) % 5120;
 point_addr=127-pix_y%16*8-pix_x%8;
// ram_addr=y*640+x;
end
else mem_data <=12'h000;

reg flg;
reg [11:0] color1, color2;
initial begin
 color1 = YELLOW; color2 = RED;
 flg = 1;
end
always @ (posedge clk_count[23]) begin
// color1 <= color1 + 1;
 if (flg) begin
  color2 <= color2 + 1;
  if (color2 + 1 == PURPLE) flg <= 0;
 end
 else begin
  color2 <= color2 - 1;
  if (color2 - 1 == RED) flg <= 1;
 end
end
//always @ (*) begin
// case (clk_count[26:24])
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
//  3'b000: begin color1 = YELLOW; color2 = GREEN; end
// endcase
//end

assign pix_data = (ascii[ascii_addr] >= 129) ? (ascii[ascii_addr] == 129 ? color1 : color2)
 :((ascii_addr == ascii_count && clk_count[24] == 1) ? (point[128][point_addr]?12'hFFF:12'h000) : (point[ascii[ascii_addr]][point_addr]?12'hFFF:12'h000));
//assign pix_data=point[ascii[ascii_addr]][0]?12'h111:12'h000;
//assign pix_data=pix_y;
endmodule
