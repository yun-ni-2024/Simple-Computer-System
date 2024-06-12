`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 17:39:55
// Design Name: 
// Module Name: d_trigger
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


module d_trigger (
    output reg out_q,
    input clk, in_d
    );
    always @ (posedge clk)
        out_q = in_d;
endmodule
