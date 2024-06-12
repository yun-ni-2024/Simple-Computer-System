`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/30 09:07:03
// Design Name: 
// Module Name: ALU8_tst
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


module ALU8_tst();
    wire [7:0] result; //8位运算结果
    wire zero; //结果为0标志位
    reg [7:0] a; //8位数据输入，送到ALU端口A 
    reg [7:0] b; //8位数据输入，送到ALU端口B 
    reg [3:0] aluctr; //4位ALU操作控制信号
    ALU8 ALU8_inst(.result(result),.zero(zero),.a(a),.b(b),.aluctr(aluctr));
    initial begin
        #10 begin a=8'h7f; b=8'h80; aluctr=4'b0000;end
        #100 aluctr=4'b0010;
        #100 aluctr=4'b0011;
        #100 aluctr=4'b0110;
        #100 aluctr=4'b1000;
        #100 aluctr=4'b1111;
        #100 begin a=8'h80; b=8'h7f; aluctr=4'b0010; end
        #100 aluctr=4'b0011; 
        #100 aluctr=4'b1000;
    end
endmodule
