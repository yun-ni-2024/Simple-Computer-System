`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/22 20:58:16
// Design Name: 
// Module Name: trans4to4_tst
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


module trans4to4_tst();
    wire [3:0] y0,y1,y2,y3;
    reg [3:0] d0,d1,d2,d3;
    reg [1:0] s;
    trans4to4 tran4to4_inst(
        .Y0(y0),.Y1(y1),.Y2(y2),.Y3(y3),.D0(d0),.D1(d1),.D2(d2),.D3(d3),.S(s)
    );
    initial
        begin
            d0=4'b0011;d1=4'b1100;d2=4'b1010;d3=4'b0101;
            s=2'b00;#50
            s=2'b01;#50
            s=2'b10;#50
            s=2'b11;#50
            s=2'b00;
        end
endmodule
