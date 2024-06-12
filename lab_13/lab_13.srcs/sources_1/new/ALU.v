`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:47:24
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


module ALU(
    input [31:0] dataa,
    input [31:0] datab,
    input [3:0] aluctr,
    output zero,
    output reg [31:0] result
    );
    always @ (*) begin
//    $display(aluctr, " ", dataa, " ", datab);
        case (aluctr)
            4'b0000: result = dataa + datab;
            4'b0001: result = dataa << datab;
            4'b0010: result = (dataa[31] == 1 && datab[31] == 1 && dataa < datab) || (dataa[31] == 0 && datab[31] == 0 && dataa < datab) || (dataa[31] == 1 && datab[31] == 0);
            4'b0011: result = dataa < datab;
            4'b0100: result = dataa ^ datab;
            4'b0101: result = dataa >> datab;
            4'b0110: result = dataa | datab;
            4'b0111: result = dataa & datab;
            4'b1000:  begin
            result = dataa - datab;
//            $display("sub:", dataa, "-", datab);
            end
            4'b1101: result = ($signed(dataa)) >>> datab;
            4'b1111: result = datab;
            default: result = 0;
        endcase
    end
    
    assign zero = (dataa == datab);
    
endmodule
