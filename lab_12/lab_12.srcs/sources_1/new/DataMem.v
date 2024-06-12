`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 10:51:29
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input re, we, clk,
    input [31:0] addr,
    input [31:0] DataIn,
    output reg [31:0] DataOut
);

    reg [31:0] mem [1023:0];
    
    always @ (negedge clk) begin
        if (we) mem[addr] <= DataIn;
    end
    
    always @ (*) begin
        if (re) DataOut <= mem[addr];
    end

endmodule
