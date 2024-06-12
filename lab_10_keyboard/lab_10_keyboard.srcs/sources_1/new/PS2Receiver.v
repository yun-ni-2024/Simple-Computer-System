`timescale 1ns / 1ps

module PS2Receiver(
    input key,
    input clk,
    input kclk,
    input kdata,
    output [7:0] keycodeout,
    output ready
    );
    wire kclkf, kdataf;
    reg [7:0]datacur;
    reg [7:0]dataprev;
    reg [3:0]cnt;          //接受串行位数
    reg [7:0]keycode;
    reg flag;            //接受1帧数据
    reg readyflag;
    
    initial begin
        keycode[7:0]<=8'b00000000;
        cnt<=4'b0000;
        readyflag<=1'b0;
 //       flag<=1'b0;
    end
    
debouncer debounce(      //消抖
    .clk(clk),
    .I0(kclk),
    .I1(kdata),
    .O0(kclkf),
    .O1(kdataf)
);
    
always@(negedge(kclkf))begin
    case(cnt)
    0:;//Start bit
    1:datacur[0]<=kdataf;
    2:datacur[1]<=kdataf;
    3:datacur[2]<=kdataf;
    4:datacur[3]<=kdataf;
    5:datacur[4]<=kdataf;
    6:datacur[5]<=kdataf;
    7:datacur[6]<=kdataf;
    8:datacur[7]<=kdataf;
    9:flag<=1'b1;
    10:flag<=1'b0;
     endcase
        if(cnt<=9) cnt<=cnt+1;
        else if(cnt==10)  cnt<=0;
end

always @(posedge flag)begin
    if (dataprev!=datacur)begin
//        keycode[31:24]<=keycode[23:16];
//        keycode[23:16]<=keycode[15:8];
 //       keycode[15:8]<=dataprev;
        keycode<=datacur;
        dataprev<=datacur;
        readyflag<=1'b1;
    end
end
    
assign keycodeout=keycode;
assign ready=readyflag;    
endmodule

