`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/11 09:05:16
// Design Name: 
// Module Name: cntr4u
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


module cntr4u(
    input CLK, CLR, LD, ENP, ENT,
    input [3:0] D,
    output reg [3:0] Q,
    output reg RCO
    );
    always @ (posedge CLK) begin
        if (CLR) Q <= 0;
        if (LD) Q <= D;
        if (!CLR && !LD && ENP && ENT) Q <= Q + 1;
        RCO <= (Q == 4'b1111 && ENT) ? 1 : 0;
    end
endmodule
