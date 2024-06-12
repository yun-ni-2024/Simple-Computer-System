`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 15:52:23
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
    output [31:0] dbg_rf1, dbg_rf2, dbg_rf3
    );
    
    reg [31:0] rf [31:0];
    
    //For testing
    integer i;
    initial begin
//        rf[0] = 0;
        for (i = 0; i < 32; i = i + 1) rf[i] = 0;
//        rf[2] = 32'h00100010;
    end
    //
//    always @ (*) begin
//        rf[0] = 0;
//    end
    
    always @ (*) begin
        busA = rf[ra];
        busB = rf[rb];
    end
    
    always @ (negedge clk) begin
        if (RegWr)
            if (rw != 0) rf[rw] = busW;
    end
    
    
    
    assign dbg_rf1 = rf[12];
    assign dbg_rf2 = rf[14];
    assign dbg_rf3 = rf[18];

endmodule
