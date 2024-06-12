`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/30 09:22:55
// Design Name: 
// Module Name: CLA4_tst
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


module CLA4_tst();
    wire [3:0] f;
    wire cout;
    reg [3:0] x, y;
    reg cin = 0;
    CLA4 CLA4_inst(.f(f),.cout(cout),.x(x),.y(y),.cin(cin));
    initial begin
        begin x = 4'b1000; y = 4'b0111; end
    end
endmodule
