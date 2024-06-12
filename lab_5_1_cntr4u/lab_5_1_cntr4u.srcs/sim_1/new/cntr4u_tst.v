`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/11 09:18:56
// Design Name: 
// Module Name: cntr4u_tst
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


module cntr4u_tst();
    reg CLK, CLR, LD, ENP, ENT;
    reg [3:0] D;
    wire [3:0] cntr4uQ;
    wire cntr4uRCO;
    always begin // 10 ns 时钟周期
        #5.5 CLK = 0; // 5.5 ns 高电平
        #4.0 CLK = 1; // 4.0 ns 低电平
        #0.5 ; // Plus 0.5 ns 转换时间
    end
    cntr4u U1(
        .CLK(CLK), .CLR(CLR), .LD(LD), .ENP(ENP), .ENT(ENT), .D(D), .Q(cntr4uQ), .RCO(cntr4uRCO)
    );
    initial begin
        CLR = 0; LD = 0; ENP = 0; ENT =0; D = 0; // 输入信号初始化
        #10 ; // 等待复位结束
        CLR = 1; D = 4'b1111; #10 // 计数器清零
        #10 ;
        CLR = 0; LD = 1; #10 // 置数 1111
        LD = 0; ENP = 1; #10 // 保持 (ENT=0)
        ENT = 1; #320 // 加法计数 32 个时钟周期
        ENT = 0; #20 // 保持，RCO=0
        $stop(1);
    end
endmodule
