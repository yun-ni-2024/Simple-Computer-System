`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:31:28
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
    input clk,
    input [4:0] ra, rb, rw,
    input [31:0] busW,
    input RegWr,
    output reg [31:0] busA, busB,
    output [31:0] dbg_rf1, dbg_rf2
    );
    
    reg [31:0] rf [31:0];
    
    //For testing
    integer i;
    initial begin
//        rf[0] = 0;
        for (i = 0; i < 32; i = i + 1) rf[i] = 0;
    end
    //
//    always @ (*) begin
//        rf[0] = 0;
//    end
    
//    assign busA = rf[ra];
//    assign busB = rf[rb];
    always @ (*) begin
        busA = rf[ra];
        busB = rf[rb];
    end
    
    always @ (negedge clk) begin
        if (RegWr)
            if (rw != 0) rf[rw] = busW;
    end
    
    assign dbg_rf1 = rf[4];
    assign dbg_rf2 = rf[5];

endmodule
