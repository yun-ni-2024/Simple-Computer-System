`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/22 20:48:12
// Design Name: 
// Module Name: trans4to4
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


module trans4to4(
    output reg [3:0] Y0,Y1,Y2,Y3,
    input [3:0] D0,D1,D2,D3,
    input [1:0] S
    );
    always @(*)
        case(S)
            2'b00:begin Y0=D0;Y1=4'bz;Y2=4'bz;Y3=4'bz; end
            2'b01:begin Y0=4'bz;Y1=D1;Y2=4'bz;Y3=4'bz; end
            2'b10:begin Y0=4'bz;Y1=4'bz;Y2=D2;Y3=4'bz; end
            2'b11:begin Y0=4'bz;Y1=4'bz;Y2=4'bz;Y3=D3; end
        endcase
endmodule
