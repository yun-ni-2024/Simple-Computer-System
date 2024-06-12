`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/26 21:48:50
// Design Name: 
// Module Name: enc8to3
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


module enc8to3(
    output reg [2:0] Y,
    input [7:0] A
    );
    always @(*)
        if (A[7]) Y = 0;
        else if (A[6]) Y = 1;
        else if (A[5]) Y = 2;
        else if (A[4]) Y = 3;
        else if (A[3]) Y = 4;
        else if (A[2]) Y = 5;
        else if (A[1]) Y = 6;
        else if (A[0]) Y = 7;
endmodule
