`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:43:59
// Design Name: 
// Module Name: MUX3
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


module MUX3(
    input [31:0] din0, din1, din2,
    input [1:0] s,
    output reg [31:0] dout
    );
    
    always @ (*) begin
        case (s)
            2'b00: dout = din0;
            2'b01: dout = din1;
            2'b10: dout = din2;
            default: dout = 0;
        endcase
    end
    
endmodule
