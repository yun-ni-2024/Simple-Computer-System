`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/19 12:21:42
// Design Name: 
// Module Name: multi_8b
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


module multi_8b(
    input clk, //时钟
    input rst_n, //复位信号，低有效
    input [7:0] x, //被乘数
    input [7:0] y, //乘数
    input in_valid, //=1有效时，乘法器开始工作
    output [15:0] p, //乘积
    output out_valid //=1有效时，表示乘法器结束工作    
    );
    reg [3:0] cnt;
    always @ (posedge clk) begin
        //if (rst_n) cnt <= 0;
        if (!rst_n) cnt <= 8;
        else if (in_valid && cnt != 0) cnt <= cnt - 1;
    end

    reg [7:0] rx, rp;
    reg [8:0] ry;
    
    wire [7:0] aluout;
    wire c;
    parameter ALU_ADD = 4'b0000;
    reg [7:0] f;
    reg [7:0] add;
    ALU8 alu(rp, add, ALU_ADD, aluout, c);
    
    always @ (posedge clk) begin
        //if (rst_n) {rp, ry, rx} <= 0;
        if (!rst_n) begin rp <= 8'b0; rx <= x; ry <= {y, 1'b0}; end
        else if (in_valid && cnt != 0) //begin {rp[6:0], ry} = {aluout, ry} >> 1; rp[7] = rp[6]; end
            begin
                case ({ry[1], ry[0]})
                    2'b01: begin {rp[6:0], ry} = {rp + rx, ry} >> 1; rp[7] = rp[6]; end
                    2'b10: begin {rp[6:0], ry} = {rp + ~rx + 1, ry} >> 1; rp[7] = rp[6]; end
                    default: begin {rp[6:0], ry} = {rp, ry} >> 1; rp[7] = rp[6]; end
                endcase
            end
    end
    
    assign out_valid = (cnt == 0);
    assign p = {rp, ry[8:1]};
endmodule
