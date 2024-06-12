`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 13:12:39
// Design Name: 
// Module Name: barrelsft8_tst
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


module barrelsft8_tst();
    wire [7:0] dout;
    reg [7:0] din;
    reg [2:0] shamt; //移动位数
    reg LR; // LR=1 时右移，LR=0 时左移
    reg AL; // AL=1 时算术右移，AR=0 时逻辑右移
    barrelsft8 barrelsft8_inst(dout,din,shamt,LR,AL);
    initial begin
        #10 begin din=8'hc5;LR=1;shamt=3'b1; end
        #20 shamt=3'b011;
        #20 shamt=3'b101;
        #20 shamt=3'b111;
        #20 begin LR=0; AL=0; shamt=3'b1;end
        #20 shamt=3'b010;
        #20 shamt=3'b100;
        #20 shamt=3'b111;
        #20 begin LR=0; AL=1; shamt=3'b1;end
        #20 shamt=3'b010;
        #20 shamt=3'b100;
        #20 shamt=3'b111;
        #20 $stop;
    end
endmodule
