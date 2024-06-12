`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 19:04:45
// Design Name: 
// Module Name: d_register_tst
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


module d_register_tst();
    wire q,qn;
    reg clk,d,pr_1,clr_1,we;
    d_register d_register_inst(q,qn,clk,d,pr_1,clr_1,we);
    always
        # 5 clk=~clk;
        initial begin
        clk = 0;d = 1;clr_1 = 1;pr_1 = 1;we = 0;
        #8 we = 1;
        #18 d = 0;
        #18 d = 1;
        #18 clr_1 = 0;
        #18 clr_1 = 1;
        #18 d = 0;
        #18 pr_1 = 0;
        #18 pr_1 = 1;
        #18 we = 0; d = 1;
        #18 pr_1 = 0;
        #18 $stop;
    end
endmodule
