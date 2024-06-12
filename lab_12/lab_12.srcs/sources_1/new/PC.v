`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 11:07:45
// Design Name: 
// Module Name: PC
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


module PC(
    input clk, rst,
    input [31:0] PCin,
    output [31:0] PCout
);

    reg [31:0] PCreg;
    
    always @ (posedge rst) begin
        PCreg <= 32'h00400000;
    end
    
    always @ (posedge clk) begin
        PCreg <= PCin;
    end
    
    assign PCout = PCreg;

endmodule
