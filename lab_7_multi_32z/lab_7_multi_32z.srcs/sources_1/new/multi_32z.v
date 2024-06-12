`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/22 17:20:16
// Design Name: 
// Module Name: multi_32z
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


module multi_32z(
    input [31:0] x,
    input [31:0] y,
    output reg [63:0] p
);
    reg [63:0] stored0;
    reg [63:0] stored1;
    reg [63:0] stored2;
    reg [63:0] stored3;
    reg [63:0] stored4;
    reg [63:0] stored5;
    reg [63:0] stored6;
    reg [63:0] stored7;
    reg [63:0] stored8;
    reg [63:0] stored9;
    reg [63:0] stored10;
    reg [63:0] stored11;
    reg [63:0] stored12;
    reg [63:0] stored13;
    reg [63:0] stored14;
    reg [63:0] stored15;
    reg [63:0] stored16;
    reg [63:0] stored17;
    reg [63:0] stored18;
    reg [63:0] stored19;
    reg [63:0] stored20;
    reg [63:0] stored21;
    reg [63:0] stored22;
    reg [63:0] stored23;
    reg [63:0] stored24;
    reg [63:0] stored25;
    reg [63:0] stored26;
    reg [63:0] stored27;
    reg [63:0] stored28;
    reg [63:0] stored29;
    reg [63:0] stored30;
    reg [63:0] stored31;
    
    reg [63:0] add_1_0;
    reg [63:0] add_1_1;
    reg [63:0] add_1_2;
    reg [63:0] add_1_3;
    reg [63:0] add_1_4;
    reg [63:0] add_1_5;
    reg [63:0] add_1_6;
    reg [63:0] add_1_7;
    reg [63:0] add_1_8;
    reg [63:0] add_1_9;
    reg [63:0] add_1_10;
    reg [63:0] add_1_11;
    reg [63:0] add_1_12;
    reg [63:0] add_1_13;
    reg [63:0] add_1_14;
    reg [63:0] add_1_15;
 
    reg [63:0] add_2_0;
    reg [63:0] add_2_1;
    reg [63:0] add_2_2;
    reg [63:0] add_2_3;
    reg [63:0] add_2_4;
    reg [63:0] add_2_5;
    reg [63:0] add_2_6;
    reg [63:0] add_2_7;
    
    reg [63:0] add_3_0;
    reg [63:0] add_3_1;
    reg [63:0] add_3_2;
    reg [63:0] add_3_3;
    
    reg [63:0] add_4_0;
    reg [63:0] add_4_1;
    
    always @ (*) begin
        stored0 = y[0] ? {64'b0, x} : 64'b0;
        stored1 = y[1] ? {63'b0, x, 1'b0} : 64'b0;
        stored2 = y[2] ? {62'b0, x, 2'b0} : 64'b0;
        stored3 = y[3] ? {61'b0, x, 3'b0} : 64'b0;
        stored4 = y[4] ? {60'b0, x, 4'b0} : 64'b0;
        stored5 = y[5] ? {59'b0, x, 5'b0} : 64'b0;
        stored6 = y[6] ? {58'b0, x, 6'b0} : 64'b0;
        stored7 = y[7] ? {57'b0, x, 7'b0} : 64'b0;
        stored8 = y[8] ? {56'b0, x, 8'b0} : 64'b0;
        stored9 = y[9] ? {55'b0, x, 9'b0} : 64'b0;
        stored10 = y[10] ? {54'b0, x, 10'b0} : 64'b0;
        stored11 = y[11] ? {53'b0, x, 11'b0} : 64'b0;
        stored12 = y[12] ? {52'b0, x, 12'b0} : 64'b0;
        stored13 = y[13] ? {51'b0, x, 13'b0} : 64'b0;
        stored14 = y[14] ? {50'b0, x, 14'b0} : 64'b0;
        stored15 = y[15] ? {49'b0, x, 15'b0} : 64'b0;
        stored16 = y[16] ? {48'b0, x, 16'b0} : 64'b0;
        stored17 = y[17] ? {47'b0, x, 17'b0} : 64'b0;
        stored18 = y[18] ? {46'b0, x, 18'b0} : 64'b0;
        stored19 = y[19] ? {45'b0, x, 19'b0} : 64'b0;
        stored20 = y[20] ? {44'b0, x, 20'b0} : 64'b0;
        stored21 = y[21] ? {43'b0, x, 21'b0} : 64'b0;
        stored22 = y[22] ? {42'b0, x, 22'b0} : 64'b0;
        stored23 = y[23] ? {41'b0, x, 23'b0} : 64'b0;
        stored24 = y[24] ? {40'b0, x, 24'b0} : 64'b0;
        stored25 = y[25] ? {39'b0, x, 25'b0} : 64'b0;
        stored26 = y[26] ? {38'b0, x, 26'b0} : 64'b0;
        stored27 = y[27] ? {37'b0, x, 27'b0} : 64'b0;
        stored28 = y[28] ? {36'b0, x, 28'b0} : 64'b0;
        stored29 = y[29] ? {35'b0, x, 29'b0} : 64'b0;
        stored30 = y[30] ? {34'b0, x, 30'b0} : 64'b0;
        stored31 = y[31] ? {33'b0, x, 31'b0} : 64'b0;
        
        add_1_0 = stored0 + stored1;
        add_1_1 = stored2 + stored3;
        add_1_2 = stored4 + stored5;
        add_1_3 = stored6 + stored7;
        add_1_4 = stored8 + stored9;
        add_1_5 = stored10 + stored11;
        add_1_6 = stored12 + stored13;
        add_1_7 = stored14 + stored15;
        add_1_8 = stored16 + stored17;
        add_1_9 = stored18 + stored19;
        add_1_10 = stored20 + stored21;
        add_1_11 = stored22 + stored23;
        add_1_12 = stored24 + stored25;
        add_1_13 = stored26 + stored27;
        add_1_14 = stored28 + stored29;
        add_1_15 = stored30 + stored31;
        
        add_2_0 = add_1_0 + add_1_1;
        add_2_1 = add_1_2 + add_1_3;
        add_2_2 = add_1_4 + add_1_5;
        add_2_3 = add_1_6 + add_1_7;
        add_2_4 = add_1_8 + add_1_9;
        add_2_5 = add_1_10 + add_1_11;
        add_2_6 = add_1_12 + add_1_13;
        add_2_7 = add_1_14 + add_1_15;
        
        add_3_0 = add_2_0 + add_2_1;
        add_3_1 = add_2_2 + add_2_3;
        add_3_2 = add_2_4 + add_2_5;
        add_3_3 = add_2_6 + add_2_7;
        
        add_4_0 = add_3_0 + add_3_1;
        add_4_1 = add_3_2 + add_3_3;
        
        p = add_4_0 + add_4_1;
    end
endmodule
