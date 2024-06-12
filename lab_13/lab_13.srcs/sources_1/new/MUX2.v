`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:41:26
// Design Name: 
// Module Name: MUX2
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


module MUX2(
    input [31:0] din0, din1,
    input s,
    output reg [31:0] dout
    );
    
    always @ (*) begin
        case (s)
            1'b0: dout = din0;
            1'b1: dout = din1;
            default: dout = 0;
        endcase
    end
    
endmodule
