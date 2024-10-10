`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 16:45:19
// Design Name: 
// Module Name: scancode_to_ascii
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


module scancode_to_ascii(addr,outdata);
input [7:0] addr;
output  [7:0] outdata;
reg [7:0] kbscantoasc[255:0];
initial
begin
    $readmemh("E:/vivado/lab9/lab9/scancode.txt", kbscantoasc, 0, 255);
end
assign   outdata = kbscantoasc[addr];

endmodule