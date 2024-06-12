`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 19:22:47
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
    reg [3:0] d;
    wire [3:0] d0,d1,d2,d3;
    reg [1:0] s;
    integer i;
    dmux4to1 inst(
        .d(d),.s(s),.d0(d0),.d1(d1),.d2(d2),.d3(d3)
    );
initial
    begin
        s=2'b00;
        for(i=0;i<=15;i=i+1)begin d=i;#5; end
        s=2'b01; 
        for(i=0;i<=15;i=i+1)begin d=i;#5; end
        s=2'b10; 
        for(i=0;i<=15;i=i+1)begin d=i;#5; end
        s=2'b11; 
        for(i=0;i<=15;i=i+1)begin d=i;#5; end
        #20;
    end
endmodule
