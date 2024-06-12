`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 19:50:40
// Design Name: 
// Module Name: d_reg8_tst
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


module d_reg8_tst();
    wire [7:0] q;
    reg clk,pr_1,clr_1,we;
    reg [7:0] d;
    d_reg8 d_reg8_inst(q,d,clk,pr_1,clr_1,we);
    always
        # 5 clk=~clk;
        initial begin
        pr_1 = 1; clr_1 = 1;
        clk = 0;d = 8'b11110000;we = 0;
        #8 we = 1;
        #18 d = 0;
        #18 d = 8'b11110000;
        #18 d = 0;
        #18 we = 0; d = 8'b11110000;
        #18 pr_1 = 0;
        #18 clr_1 = 0;
        #18 $stop;
    end
endmodule
