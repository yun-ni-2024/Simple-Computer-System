`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 16:44:55
// Design Name: 
// Module Name: mux4to1_tst
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


module mux4to1_tst();
    reg a0,a1,a2,a3,s0,s1;
    wire y;
    mux4to1_1 inst(
        .a0(a0), .a1(a1), .a2(a2), .a3(a3), .s0(s0), .s1(s1), .y(y)
    );
    initial
        begin
            s0=0;s1=0;
            a0=1;a1=0;a2=0;a3=0;#20;
            a0=0;a1=1;a2=1;a3=1;#20;
            s0=0;s1=1; 
            a0=0;a1=1;a2=0;a3=0;#20;
            a0=1;a1=0;a2=1;a3=1;#20;
            s0=1;s1=0; 
            a0=0;a1=0;a2=1;a3=0;#20;
            a0=1;a1=1;a2=0;a3=1;#20;
            s0=1;s1=1; 
            a0=0;a1=0;a2=0;a3=1;#20;
            a0=1;a1=1;a2=1;a3=0;#20;
        end 
endmodule

