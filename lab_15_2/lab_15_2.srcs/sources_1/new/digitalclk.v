`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/29 17:44:04
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
    input clk, rst,
    output reg [7:0] h, m, s
    );
    reg [30:0] cnt;
    initial begin
        h <= 0;
        m <= 0;
        s <= 0;
    end
    always @ (posedge clk) begin
        if (rst) begin h <= 0; m <= 0; s <= 0; cnt <= 0; end
        else if (cnt >= 100000000)
            begin
                cnt <= 0;
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
        else cnt <= cnt + 1;
    end
endmodule
