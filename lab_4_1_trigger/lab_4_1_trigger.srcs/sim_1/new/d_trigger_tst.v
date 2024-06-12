`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 17:57:17
// Design Name: 
// Module Name: d_trigger_tst
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


module d_trigger_tst();
    wire out_q;
    reg clk;
    reg in_d;
    d_trigger d_trigger_inst(.clk(clk),.in_d(in_d),.out_q(out_q));
    always
        # 5 clk=~clk;
        initial begin 
            clk=0;in_d=1; 
            #18 in_d=0; 
            #18 in_d=1;
            #18 in_d=0;
            #18 in_d=1;
            #18 in_d=0;
            $stop;
        end
endmodule
