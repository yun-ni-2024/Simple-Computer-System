`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 11:00:10
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input [4:0] ra, rb, rw,
    input [31:0] busW,
    input RegWr,
    input clk,
    output [31:0] busA, busB
);

    reg [31:0] rf [31:0];
    
    assign busA = rf[ra];
    assign busB = rf[rb];
    
    always @ (posedge clk) begin
        if (RegWr) rf[rw] = busW;
    end

endmodule
