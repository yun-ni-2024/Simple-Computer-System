`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 23:08:56
// Design Name: 
// Module Name: Adder8
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


module Adder8(
    input [3:0] x, y,
    input sub,
    output [3:0] f,
    output ZF,
    output cout
    );
    CLA4 cla4(x[3:0], y[3:0], sub, f[3:0], cout);
    assign ZF = ~(|f);
endmodule
