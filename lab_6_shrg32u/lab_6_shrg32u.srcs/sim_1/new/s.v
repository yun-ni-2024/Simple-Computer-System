`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 17:11:19
// Design Name: 
// Module Name: s
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


module s();
    reg clk;
    reg rst;//清零
    reg ld;//载入
    reg [31:0] seed;//伪随机生成种子
    wire [31:0] data;
    shrg32u inst(clk, rst, ld, seed, data);
    initial clk = 1'b0;
    always # 5 clk = ~clk;
    initial begin
        rst = 1; ld = 0;
        #15
        rst = 0; ld = 1; seed = 12345;
        #15
        ld = 0;
    end
endmodule
