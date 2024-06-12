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
 output wire [11:0] pix_data 
);
reg [18:0] ram_addr;
reg [11:0] mem_data;

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

always@(posedge pix_clk )
 if(pix_rst == 1)
 mem_data <= 12'h000;
 else
 if (pix_valid==1) 
 begin
  //输出彩条
// casez(pix_x)
// 10'b00_00??_???? : mem_data <= RED ;
// 10'b00_01??_???? : mem_data <= ORANGE;
// 10'b00_10??_???? : mem_data <= YELLOW;
// 10'b00_11??_???? : mem_data <= GREEN ;
// 10'b01_00??_???? : mem_data <= CYAN ;
// 10'b01_01??_???? : mem_data <= BLUE ;
// 10'b01_10??_???? : mem_data <= PURPLE;
// 10'b01_11??_???? : mem_data <= BLACK ;
// 10'b10_00??_???? : mem_data <= WHITE ;
// 10'b10_01??_???? : mem_data <= GRAY ;
// default: mem_data <= PURPLE ;
// endcase

 //按照行优先的格式进行计算像素地址，需要根据 COE 文件排列次序进行调整
 ram_addr<=pix_y*640+pix_x; 
 end
 else mem_data <=12'h000;

vga_mem my_pic(.addra({ram_addr}),
.clka(pix_clk),
.ena(1'b1),
.wea(1'b0),
.dina(12'd0),
.douta(pix_data));

//assign pix_data=mem_data;
//assign pix_data=pix_x;
endmodule
