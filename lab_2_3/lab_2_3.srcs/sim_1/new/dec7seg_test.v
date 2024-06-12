`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/27 09:08:14
// Design Name: 
// Module Name: dec7seg_test
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


module dec7seg_test();
    wire [6:0] O_seg;
    wire [7:0] O_led;
    reg [3:0] I;
    reg [2:0] S;
    dec7seg dec7seg_impl(.O_seg(O_seg),.O_led(O_led),.I(I),.S(S));
    initial
        begin
            begin S = 0; I = 0; end
            #50 begin S = 1; I = 1; end
            #50 begin S = 2; I = 2; end
            #50 begin S = 3; I = 3; end
            #50 begin S = 4; I = 4; end
            #50 begin S = 5; I = 5; end
            #50 begin S = 6; I = 6; end
            #50 begin S = 7; I = 7; end
            #50 begin S = 7; I = 8; end
            #50 begin S = 7; I = 9; end
            #50 begin S = 7; I = 10; end
            #50;
        end
endmodule
