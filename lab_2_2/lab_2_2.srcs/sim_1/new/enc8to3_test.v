`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/26 22:02:16
// Design Name: 
// Module Name: enc8to3_test
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


module enc8to3_test();
    wire [2:0] Y;
    reg [7:0] A;
    enc8to3 enc8to3_impl(.Y(Y),.A(A));
    initial
        begin
            #10 begin A = 8'b11110100; end
            #100 begin A = 8'b01110110; end
            #100 begin A = 8'b00110110; end
            #100 begin A = 8'b00010100; end
            #100 begin A = 8'b00001110; end
            #100 begin A = 8'b00000100; end
            #100 begin A = 8'b00000011; end
            #100 begin A = 8'b00000001; end
            #100 begin A = 8'b00000000; end
        end
endmodule
