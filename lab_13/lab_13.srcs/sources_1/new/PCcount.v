`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 08:37:54
// Design Name: 
// Module Name: PCcount
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


module PCcount(
    input clk,
    input [31:0] PCin,
    output reg [31:0] PCout
    );
    
//    reg PC;
    
//    always @ (*) begin
//        PC = PCin;
//    end
    
    always @ (posedge clk) begin
        PCout = PCin;
//        PCout = 0;
    end
    
endmodule
