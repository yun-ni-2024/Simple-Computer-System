`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 17:05:02
// Design Name: 
// Module Name: shrg32u
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


module shrg32u(
    input clk,
    input rst,//清零
    input ld,//载入
    input [31:0] seed,//伪随机生成种子
    output reg [31:0] data
    );
    always @ (posedge clk) begin
        if (rst) data <= 0;
        else if (ld) data <= seed;
        else begin//整体移位
            data[0] <= data[31];
            data[1] <= data[0] ^ data[31];//在某些位进行异或操作打乱
            data[2] <= data[1] ^ data[31];
            data[3] <= data[2] ^ data[31];
            data[4] <= data[3];
            data[5] <= data[4] ^ data[31];
            data[6] <= data[5];
            data[7] <= data[6] ^ data[31];
            data[8] <= data[7];
            data[9] <= data[8];
            data[10] <= data[9];
            data[11] <= data[10];
            data[12] <= data[11];
            data[13] <= data[12];
            data[14] <= data[13];
            data[15] <= data[14];
            data[16] <= data[15];
            data[17] <= data[16];
            data[18] <= data[17];
            data[19] <= data[18];
            data[20] <= data[19];
            data[21] <= data[20];
            data[22] <= data[21];
            data[23] <= data[22];
            data[24] <= data[23];
            data[25] <= data[24];
            data[26] <= data[25];
            data[27] <= data[26];
            data[28] <= data[27];
            data[29] <= data[28];
            data[30] <= data[29];
            data[31] <= data[30];
        end
    end
endmodule
