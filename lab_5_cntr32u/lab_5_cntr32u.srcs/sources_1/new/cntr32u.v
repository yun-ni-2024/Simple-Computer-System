`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/16 20:30:20
// Design Name: 
// Module Name: cntr32u
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


module cntr32u(
    input CLK, CLR, LD, ENP, ENT,
    input [31:0] D,
    output reg [31:0] Q,
    output reg RCO
    );
    always @ (posedge CLK) begin
        if (CLR) Q <= 0;
        if (LD) Q <= D;
        if (!CLR && !LD && ENP && ENT) Q <= Q + 1;
        RCO <= (Q == -1 && ENT) ? 1 : 0;
    end
endmodule
