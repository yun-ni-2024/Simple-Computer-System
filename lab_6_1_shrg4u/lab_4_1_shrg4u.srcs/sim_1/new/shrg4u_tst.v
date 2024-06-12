`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 08:20:25
// Design Name: 
// Module Name: shrg4u_tst
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


module shrg4u_tst( );
    reg Tclk, CLR, S0, S1, RIN, LIN;
    reg [3:0] I; // A-D = I[3:0]
    wire [3:0] Q; // QA-QD = Q[3:0]
    shrg4u UUT (
        .CLK(Tclk), .CLR(CLR), .RIN(RIN), .LIN(LIN), .S0(S0), .S1(S1), 
        .A(I[3]), .B(I[2]), .C(I[1]), .D(I[0]),
        .QA(Q[3]), .QB(Q[2]), .QC(Q[1]), .QD(Q[0])
    );
    always begin 
        #0.5 ; Tclk = 1'b1; #5 ; // 定义时钟周期 10ns，上升沿发生在 at 10.5ns, 20.5ns,....
        Tclk = 1'b0; #4.5 ;
    end
    initial begin : TB
        integer ii, j;
        #10 ; // 等待实验板系统复位时间
        RIN = 1'b0; LIN = 1'b0; // 设置左、右移入位为 0
        for (ii=0; ii<=15; ii=ii+1) begin // 验证载入、保持和清零功能
            CLR = 1'b0; {S1,S0} = 2'b11; I[3:0] = ii; #10 ; // 载入数据，并等待时钟信号有效后验证
            if (Q != I[3:0]) $display("S1S0 = 11, ABCD = %4b, QA-QD = %4b, load failed", I, Q);
            {S1,S0} = 2'b00; #10 ; // 保持数据,并等待时钟信号有效后验证
            if (Q != I[3:0]) $display("S1S0 = 00, ABCD = %4b, now QA-QD = %4b, hold failed", I, Q);
            CLR = 1'b1; #10 ; // 清零信号有效，并等待时钟信号有效后验证
            if (Q != 4'b0) $display("CLR = 1, QA-QD = %4b, clear failed", Q);
        end
        $display("Clear, load, and hold test completed");
        CLR = 1'b0; LIN=1'b1; //清零信号无效，进入移位状态
        $display("Starting shift-right test for all states");
        for (ii=0; ii<=31; ii=ii+1) begin // 右移测试
            {S1,S0} = 2'b11; { RIN, I[3:0]} = ii[4:0]; #10 ; // 载入初始数据，等待时钟信号
            {S1,S0} = 2'b01; #10 ; // 右移，等待时钟信号有效后验证
            if (Q != {RIN,ii[3:1]})
            $display("S1S0 = 01, old QA-QD = %4b, RIN,LIN = %2b, QA-QD = %4b, shift-right failed", 
            ii[3:0], {RIN,LIN}, Q);
        end
        $display("All states shift-right test completed");
        $display("Starting shift-left test for all states");
        RIN = 1'b0; LIN = 1'b1; // 左移移入位置 1 
        for (ii=0; ii<=15; ii=ii+1) begin // 左移测试
            {S1,S0} = 2'b11; I[3:0] = ii; #10 ; //载入初始数据，等待时钟信号
            {S1,S0} = 2'b10; #10 ; // 左移，等待时钟信号有效后验证
            if (Q != {ii[2:0],LIN})
            $display("S1S0 = 10, old QA-QD = %4b, RIN,LIN = %2b, QA-QD = %4b, shift-left failed", 
            ii[3:0], {RIN,LIN}, Q);
        end
        $display("All states shift-left test completed");
        $stop;
    end
endmodule
