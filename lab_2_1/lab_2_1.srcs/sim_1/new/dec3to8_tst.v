`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/26 16:57:22
// Design Name: 
// Module Name: dec3to8_tst
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


module dec3to8_tst();
    wire [7:0] O;
    reg [2:0] I;
    reg En;
    dec3to8 dec3to8_impl(.O(O),.I(I),.En(En));
    initial
        begin
            begin En = 1'b0; end
            #100
            begin En = 1'b1; I = 3'b000; end
            #100
            begin En = 1'b1; I = 3'b001; end
            #100
            begin En = 1'b1; I = 3'b010; end
            #100
            begin En = 1'b1; I = 3'b011; end
            #100
            begin En = 1'b1; I = 3'b100; end
            #100
            begin En = 1'b1; I = 3'b101; end
            #100
            begin En = 1'b1; I = 3'b110; end
            #100
            begin En = 1'b1; I = 3'b111; end
            #100
            begin En = 1'b0; end
        end
endmodule
