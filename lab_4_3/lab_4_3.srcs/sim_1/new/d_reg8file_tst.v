`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 20:58:42
// Design Name: 
// Module Name: d_reg8file_tst
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


module d_reg8file_tst();
    reg [7:0] busw;
    reg [2:0] ra;
    reg [2:0] rb;
    //reg [2:0] rw;
    reg clk;
    wire [7:0] busa;
    wire [7:0] busb;
    d_reg8file d_reg8file_inst(busw, ra, rb, clk, busa, busb);
    always
        # 5 clk=~clk;
        initial begin
        clk = 0;busw = 8'b11110000;ra = 1;
        #18 ra = 1;rb = 3;
        #18 busw = 8'b11111111;ra = 3;
        #18 ra = 1;rb = 3;
        #18 busw = 8'b00001111;ra = 1;
        #18 ra = 1;rb = 3;
        #18 $stop;
    end
endmodule
