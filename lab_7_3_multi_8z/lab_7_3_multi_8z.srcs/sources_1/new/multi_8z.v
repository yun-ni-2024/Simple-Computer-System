`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/20 13:24:53
// Design Name: 
// Module Name: multi_8z
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


module multi_8z(
    input [7:0] x,
    input [7:0] y,
    output reg [15:0] p
);
    reg [15:0] stored0;
    reg [15:0] stored1;
    reg [15:0] stored2;
    reg [15:0] stored3;
    reg [15:0] stored4;
    reg [15:0] stored5;
    reg [15:0] stored6;
    reg [15:0] stored7;
 
    reg [15:0] add0;
    reg [15:0] add1;
    reg [15:0] add2;
    reg [15:0] add3;
    
    reg [15:0] add01, add23;
    
    always @ (*) begin
        stored0 = y[0]? {16'b0, x} : 16'b0;
        stored1 = y[1]? {15'b0, x, 1'b0} : 16'b0;
        stored2 = y[2]? {14'b0, x, 2'b0} : 16'b0;
        stored3 = y[3]? {13'b0, x, 3'b0} : 16'b0;
        stored4 = y[4]? {12'b0, x, 4'b0} : 16'b0;
        stored5 = y[5]? {11'b0, x, 5'b0} : 16'b0;
        stored6 = y[6]? {10'b0, x, 6'b0} : 16'b0;
        stored7 = y[7]? {9'b0, x, 7'b0} : 16'b0;
        
        add0 = stored1 + stored0;
        add1 = stored3 + stored2;
        add2 = stored5 + stored4;
        add3 = stored7 + stored6;
        
        add01 = add1 + add0;
        add23 = add3 + add2;
        
        p = add01 + add23;
    end
endmodule
