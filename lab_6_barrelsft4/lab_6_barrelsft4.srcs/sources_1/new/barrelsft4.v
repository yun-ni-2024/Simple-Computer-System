`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 16:56:16
// Design Name: 
// Module Name: barrelsft4
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


module barrelsft8(
    output reg [3:0] dout,
    input [3:0] din,
    input [1:0] shamt, //移动位数
    input LR, // LR=1 时右移，LR=0 时左移
    input AL // AL=1 时算术右移，AR=0 时逻辑右移
    );
    always @ (*)
        begin
            dout = din;
            if (shamt[0])
                begin
                    if (LR) dout = dout << 1;
                    else dout = dout >> 1;
                    if (AL) dout[3] = din[3];
                end
            if (shamt[1])
                begin
                    if (LR) dout = dout << 2;
                    else dout = dout >> 2;
                    if (AL) begin dout[3] = din[3]; dout[2] = din[3]; end
                end
        end
endmodule
