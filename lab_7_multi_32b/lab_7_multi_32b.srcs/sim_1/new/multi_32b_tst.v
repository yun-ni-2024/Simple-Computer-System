`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/22 16:50:16
// Design Name: 
// Module Name: multi_32b_tst
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


module multi_b_tst( );
    reg clk; //芯片的时钟信号。
    reg rst_n; //低电平复位、清零信号。定义为 0 表示芯片复位；定义为 1 表示复位信号无效。
    reg in_valid; //芯片使能信号。定义为 0 表示信号无效；定义为 1 表示芯片读入输入管脚得乘数和被乘数，并将乘积复位清零。reg[7:0] x; //输入 a（被乘数），其数据位宽为 16bit.
    reg[31:0] x; //输入 a（被乘数），其数据位宽为 8bit.
    reg[31:0] y; //输入 b（乘数），其数据位宽为 8bit.
    wire[63:0] p; //乘积输出，其数据位宽为 16bit.
    wire out_valid; //乘法运算完成标志位
    multi_32b uut( .x(x),.y(y),.p(p), .clk(clk),.rst_n(rst_n),.in_valid(in_valid),.out_valid(out_valid));
    initial begin
        clk = 0;
        forever 
        #1 clk = ~clk; //??50MHZ???
    end
    initial begin
        rst_n = 1'b0;
        in_valid=1'b0;
        x =32'h7fffffff;
        y=32'h00000001;
        #10
        rst_n = 1'b1; //上电后 1us 复位信号
        in_valid=1'b1;
        #100
        rst_n = 1'b0; //上电后 1us 复位信号
        in_valid=1'b0;
        x = 8'h87;
        y = 8'h5a;
        #10;
        rst_n = 1'b1; //上电后 1us 复位信号
        in_valid=1'b1;
        #100;
        rst_n = 1'b0;
        in_valid=1'b0;
        x = 8'h0f;
        y = 8'h0f;
        #10;
        rst_n = 1'b1;
        in_valid=1'b1;
        #100;
        rst_n = 1'b0;
        in_valid=1'b0;
        x = 123;
        y = 2455;
        #10;
        rst_n = 1'b1;
        in_valid = 1'b1; //上电后 1us 复位信号
        #100;
        $stop;
    end
endmodule
