`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/30 16:31:09
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [31:0] dataa,
    input [31:0] datab,
    input [3:0] aluctr,
    output zero,
    output reg [31:0] result
);
    
//    reg sub, sig, al, sft;
//    always @ (*) begin
//        case (aluctr)
//            4'b0000: begin sub = 0; end
//            4'b0001: begin al = 0; sft = 0; end
//            4'b0010: begin sub = 1; sft = 1; end
//        endcase
//    end
    
    wire cin, cout;
    wire [31:0] f;
    reg [31:0] b;
    adder32(dataa, b, cin, f, cout);
    
    always @ (*) begin
        case (aluctr)
            4'b0000: result = dataa + datab;
            4'b0001: result = dataa << datab;
            4'b0010: result = (dataa[31] == 1 && datab[31] == 1 && dataa < datab) || (dataa[31] == 0 && datab[31] == 0 && dataa < datab) || (dataa[31] == 1 && datab[31] == 0);
            4'b0011: result = dataa < datab;
            4'b0100: result = dataa ^ datab;
            4'b0101: result = dataa >> datab;
            4'b0110: result = dataa | datab;
            4'b0111: result = dataa & datab;
            4'b1000: result = dataa - datab;
            4'b1101: result = ($signed(dataa)) >>> datab;
            4'b1111: result = datab;
            default: result = 0;
        endcase
    end
    
    assign zero = (result == 0);
    
endmodule
