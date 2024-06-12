`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 14:25:53
// Design Name: 
// Module Name: ALU8
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


module ALU8(
    output reg [7:0] result, //8位运算结果
    input [7:0] a, //8位数据输入，送到ALU端口A 
    input [7:0] b, //8位数据输入，送到ALU端口B 
    input [3:0] aluctr //4位ALU操作控制信号
    );
    wire cout1, cout2;
    wire cin = 0;
    wire ZF1, ZF2;
    wire [7:0] add, sub;
    Adder8 add0(a, b, 0, add, cout1);
    Adder8 add1(a, b, 1, sub, cout2);
    always @(*) begin
        case (aluctr)
            4'b0000: result = add;
            4'b0010: result = (a < b) ? 0 : 1;
            4'b0011:
                begin
                    if (a[7] == 0 && b[7] == 0) result = (a < b) ? 0 : 1;
                    else if (a[7] == 0 && b[7] == 1) result = 1;
                    else if (a[7] == 1 && b[7] == 0) result = 0;
                    else result = (a < b) ? 1 : 0;
                end
            4'b0110: result = a | b;
            4'b1000: result = sub;
            4'b1111: result = b;
            default: result = 0;
        endcase
    end
endmodule
