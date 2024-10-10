`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 16:43:17
// Design Name: 
// Module Name: inoutlab
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


module inoutlab(
    input CLK100MHZ,
    input PS2_CLK,
    input PS2_DATA,
    input BTNC,      //Reset
//    output [6:0]SEG,
//    output [7:0]AN,
//    output DP,
//    output [15:0] LED   //显示
    output [7:0] key_ascii,
    output reg [12:0] key_count
    );
    
reg CLK50MHZ=0; 
wire [7:0] key_data;
wire ready;
wire [31:0] seg7_data;

reg [7:0] key_prevdata;
reg [7:0] key_currentdata;
reg [7:0] key_cur;
reg ignore_next;   //忽略扫描码
reg pressing;    //键按下标志位

reg Is_Caps;
reg Is_Num;
reg Is_Ctrl;
reg Is_Alt;
reg Is_Shift;

reg [30:0] cnt;

initial begin
    cnt <= 0;
end

always @(posedge(CLK100MHZ))begin
    CLK50MHZ<=~CLK50MHZ;
//    if (cnt < 100000000) cnt <= cnt + 1;
end

PS2Receiver kbscancode (
.clk(CLK50MHZ),
.kclk(PS2_CLK),
.kdata(PS2_DATA),
.keycodeout(key_data),
.ready(ready)
);

initial begin
    key_count <= 0;
    Is_Shift <= 0;
end

reg flag;
reg [3:0] presscnt;
//扫描码识别处理流程
always @ (posedge CLK50MHZ) begin
    if (BTNC) begin
        flag <= 0;
        presscnt <= 0;
        key_count <= 0;
        key_prevdata <= 0;
        key_currentdata <= 0;
        key_cur <= 0;
        Is_Caps <= 0;
        Is_Ctrl <= 0;
        Is_Alt <= 0;
        Is_Shift <= 0;
        pressing <= 0;
        Is_Num <= 0;
    end
    else begin
        if (key_data == 8'hF0) begin
            flag <= 1;
        end
        
        
//        else if (flag && key_data != 8'hF0) begin
//            key_cur <= key_data;
//            flag <= 0;
//            pressing <= 0;
//            Is_Caps <= 0; Is_Ctrl <= 0; Is_Alt <= 0; Is_Shift <= 0; Is_Num <= 0;
////            if (key_data == 8'h58) Is_Caps <= 0;
////            if (key_data == 8'h14) Is_Ctrl <= 0;
////            if (key_data == 8'h11) Is_Alt <= 0;
////            if (key_data == 8'h12) Is_Shift <= 0;
////            if (key_data == 8'h16 || key_data == 8'h1E || key_data == 8'h26
////                || key_data == 8'h25 || key_data == 8'h2E || key_data == 8'h36 || key_data == 8'h3D
////                || key_data == 8'h3E || key_data == 8'h46 || key_data == 8'h45
////                || key_data == 8'h70 || key_data == 8'h69 || key_data == 8'h72 || key_data == 8'h7A
////                || key_data == 8'h6B || key_data == 8'h73 || key_data == 8'h74 || key_data == 8'h6C
////                || key_data == 8'h75 || key_data == 8'h7D)
////            Is_Num <= 0;
//        end
        
        
        else if (flag && key_data != 8'hF0) begin
            if (key_data == 8'h12 || key_data == 8'h59) Is_Shift <= 0;
            else if (key_data == 8'h66) begin
                flag <= 0;
                cnt <= 0;
                key_cur <= key_data;
                pressing <= 1;
                key_prevdata <= key_currentdata;
                key_currentdata <= key_data;
                key_count <= (key_count - 1) % 5120;
            end
            else if (key_data == 8'h5a) begin
                flag <= 0;
                cnt <= 0;
                key_cur <= key_data;
                pressing <= 1;
                key_prevdata <= key_currentdata;
                key_currentdata <= key_data;
                key_count <= (key_count / 80 * 80 + 80) % 5120;
            end
            
            else begin
                flag <= 0;
                cnt <= 0;
                key_cur <= key_data;
                pressing <= 1;
//                if (key_data == 8'h58) Is_Caps <= 1;
//                else if (key_data == 8'h14) Is_Ctrl <= 1;
//                else if (key_data == 8'h11) Is_Alt <= 1;
//                else if (key_data == 8'h12) Is_Shift <= 1;
//                else begin
                    key_count <= (key_count + 1) % 5120;
                    key_prevdata <= key_currentdata;
                    key_currentdata <= key_data;
//                    if (key_data == 8'h16 || key_data == 8'h1E || key_data == 8'h26
//                        || key_data == 8'h25 || key_data == 8'h2E || key_data == 8'h36 || key_data == 8'h3D
//                        || key_data == 8'h3E || key_data == 8'h46 || key_data == 8'h45
//                        || key_data == 8'h70 || key_data == 8'h69 || key_data == 8'h72 || key_data == 8'h7A
//                        || key_data == 8'h6B || key_data == 8'h73 || key_data == 8'h74 || key_data == 8'h6C
//                        || key_data == 8'h75 || key_data == 8'h7D)
//                    Is_Num <= 1;
//                end
            end
        end
        else begin
            if (key_data == 8'h12 || key_data == 8'h59) Is_Shift <= 1;
        end
    end
end

assign seg7_data[7:0] = key_ascii;
assign seg7_data[15:8] = key_currentdata;
assign seg7_data[23:16] = key_prevdata;
assign seg7_data[31:24] = key_count;


wire [7:0] ascii;
scancode_to_ascii key_asc(key_currentdata,ascii);

assign key_ascii = (Is_Shift && ascii >= 97 && ascii <= 122) ? ascii - 32 : (ascii == 91 ? 40 : (ascii == 93 ? 41 : ascii));
//assign key_ascii = Is_Shift ? (ascii == 57 ? 40 : (ascii == 48 ? 41 : (ascii >= 97 && ascii <= 122 ? ascii - 32 : ascii))) : ascii;
//assign key_ascii = (Is_Shift && ascii >= 97 && ascii <= 122) ? ascii - 32 : ascii;

endmodule
