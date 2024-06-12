`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/27 08:58:27
// Design Name: 
// Module Name: dec7seg
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


module dec7seg(
    output reg [6:0] O_seg,
    output [7:0] O_led,
    input [3:0] I,
    input [2:0] S
    );
    always @ (*)
        if (I > 9) O_seg = 0;
        else case (I)
            0 : O_seg = 7'b1000000;
            1 : O_seg = 7'b1111001;
            2 : O_seg = 7'b0100100;
            3 : O_seg = 7'b0110000;
            4 : O_seg = 7'b0011001;
            5 : O_seg = 7'b0010010;
            6 : O_seg = 7'b0000010;
            7 : O_seg = 7'b1111000;
            8 : O_seg = 7'b0000000;
            9 : O_seg = 7'b0010000;
        endcase
    assign O_led = ~(1 << S);
endmodule
