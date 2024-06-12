`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/03 22:39:31
// Design Name: 
// Module Name: DataMux
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


module DataMux(
    input [7:0] d1, d2, d3, d4,
    input [2:0] MemOp,
    output reg [31:0] DataOut
    );
    
    always @ (*) begin
        case (MemOp)
            3'b000: DataOut = {d4, d3, d2, d1};
            3'b101: DataOut = {24'h000000, d1};
            3'b110: DataOut = {16'h0000, d2, d1};
            default: begin end
        endcase
    end
    
endmodule
