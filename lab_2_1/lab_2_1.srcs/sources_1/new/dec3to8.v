`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/26 16:47:07
// Design Name: 
// Module Name: dec3to8
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


module dec3to8(
    output reg [7:0] O,
    input [2:0] I,
    input En
    );
//    assign O = (En == 1) ? 1 << I : 0; 数据流建模
//行为流建模如下
    always @(*)
        if (En == 0) O = 0;
        else
            case(I)
                0 : O = 8'b00000000;
                1 : O = 8'b00000001;
                2 : O = 8'b00000010;
                3 : O = 8'b00000100;
                4 : O = 8'b00001000;
                5 : O = 8'b00010000;
                6 : O = 8'b00100000;
                7 : O = 8'b01000000;
                8 : O = 8'b10000000;
            endcase
endmodule
