`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/11 09:27:35
// Design Name: 
// Module Name: clk1s
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


module clk1s(
    input clk,
    input rst,
    output reg clkout,
    output reg [30:0] cnt
    );
    always @ (posedge clk) begin
        if (rst) begin cnt <= 0; clkout <= 0; end
        else if (cnt == 10) begin clkout <= clkout ^ 1; cnt <= 0; end
        else cnt <= cnt + 1;
    end
endmodule
