`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 19:01:34
// Design Name: 
// Module Name: trans4to4
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


module dmux4to1(
    output reg [3:0] d0,d1,d2,d3,
    input [3:0] d,
    input [1:0] s
    );
    always @(*)
        case(s)
            2'b00:begin d0=d;d1=4'bz;d2=4'bz;d3=4'bz; end
            2'b01:begin d0=4'bz;d1=d;d2=4'bz;d3=4'bz; end
            2'b10:begin d0=4'bz;d1=4'bz;d2=d;d3=4'bz; end
            2'b11:begin d0=4'bz;d1=4'bz;d2=4'bz;d3=d; end
        endcase
endmodule
