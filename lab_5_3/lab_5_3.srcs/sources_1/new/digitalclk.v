`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 09:48:26
// Design Name: 
// Module Name: digitalclk
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


module digitalclk(
    input clk,
    input rst, //复位，有效后00:00:00
    input ld, // =1时，进入设置初值；=0时，正常及时
    input set_h, //按钮按下后，设置小时初值
    input set_m, //按钮按下后，设置分钟初值
    input set_s, //按钮按下后，设置秒数初值
    input [3:0] data_h, //设置初值高位，使用BCD码表示
    input [3:0] data_l, //设置初值低位，使用BCD码表示
    output reg [6:0] segs, //七段数码管输入值，显示数字
    output reg [7:0] an, //七段数码管控制位，控制时、分、秒
    output reg [2:0] ledout //输出3色指示灯
    );
    reg [7:0] h;
    reg [7:0] m;
    reg [7:0] s;
    reg [3:0] sh;
    reg [3:0] sl;
    reg [3:0] mh;
    reg [3:0] ml;
    reg [3:0] hh;
    reg [3:0] hl;
    reg [26:0] cnt;
    integer i, j, k;
    reg [2:0] pos;
    reg [3:0] dig;
    always @ (posedge clk or posedge rst)
        begin
            if (rst)
                begin
                    cnt <= 0;
                    h <= 0;
                    m <= 0;
                    s <= 0;
                    hh <= 0;
                    hl <= 0;
                    mh <= 0;
                    ml <= 0;
                    sh <= 0;
                    sl <= 0;
                end
            else if (cnt == 100000000)
                begin
                    cnt <= 0;
                    if (ld)
                        begin
                            if (set_h) h <= data_h * 10 + data_l;
                            if (set_m) m <= data_h * 10 + data_l;
                            if (set_s) s <= data_h * 10 + data_l;
                        end
                    else
                        begin
                            if (s == 59)
                                begin
                                    s <= 0;
                                    if (m == 59)
                                        begin
                                            m <= 0;
                                                if (h == 23) h <= 0;
                                                else h <= h + 1;
                                        end
                                    else m <= m + 1;
                                end
                            else s <= s + 1;
                        end
                    sh <= s[7:0] / 10;
                    sl <= s[7:0] % 10;
                    mh <= m[7:0] / 10;
                    ml <= m[7:0] % 10;
                    hh <= h[7:0] / 10;
                    hl <= h[7:0] % 10;
//                    for (i = 0; i < 6; i = i + 1)
//                        if (s[7:0] - i * 10 < 10)
//                            begin
//                                sh <= i;
//                                sl <= s[7:0] - i * 10;
//                                i = 6;
//                            end
//                    for (j = 0; j < 6; j = j + 1)
//                        if (m[7:0] - j * 10 < 10)
//                            begin
//                                mh <= j;
//                                ml <= m[7:0] - j * 10;
//                                j = 6;
//                            end
//                    for (k = 0; k < 6; k = k + 1)
//                        if (h[7:0] - k * 10 < 10)
//                            begin
//                                hh <= k;
//                                hl <= h[7:0] - k * 10;
//                                k = 6;
//                            end
                end
            else cnt <= cnt + 1;
        end
    always @ (*)
        begin
            an = 8'b11111111;
            pos <= cnt[14:12];
            an[pos] = 0;
            case (pos)
                0: dig <= sl[3:0];
                1: dig <= sh[3:0];
                3: dig <= ml[3:0];
                4: dig <= mh[3:0];
                6: dig <= hl[3:0];
                7: dig <= hh[3:0];
                default: dig <= 10;
            endcase
            case (dig)
	            0: segs = 7'b1000000;
		        1: segs = 7'b1111001;
	            2: segs = 7'b0100100;
	            3: segs = 7'b0110000;
	            4: segs = 7'b0011001;
	            5: segs = 7'b0010010;
	            6: segs = 7'b0000010;
	            7: segs = 7'b1111000;
	            8: segs = 7'b0000000;
	            9: segs = 7'b0010000;
	            default: segs = 7'b1111111;
	        endcase
            if (s < 5 && m == 0) ledout = 1 << (cnt % 3);
            else ledout = 0;
        end
endmodule
