`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 09:49:08
// Design Name: 
// Module Name: digitalclk_tst
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


module digitalclk_tst();
    reg clk0;
    reg rst; //复位，有效后00:00:00
    reg ld; // =1时，进入设置初值；=0时，正常及时
    reg set_h; //按钮按下后，设置小时初值
    reg set_m; //按钮按下后，设置分钟初值
    reg set_s; //按钮按下后，设置秒数初值
    reg [3:0] data_h; //设置初值高位，使用BCD码表示
    reg [3:0] data_l; //设置初值低位，使用BCD码表示
    wire [6:0] segs; //七段数码管输入值，显示数字
    wire [7:0] an; //七段数码管控制位，控制时、分、秒
    wire [2:0] ledout; //输出3色指示灯
    digitalclk digitalclk_inst(clk0, rst, ld, set_h, set_m, set_s, data_h, data_l, segs, an, ledout);
    always
        # 5 clk0 = ~clk0;
    initial begin
        rst = 0;
        #5
        clk0 = 0; rst = 1;
        #5
        rst = 0;
    end
endmodule
