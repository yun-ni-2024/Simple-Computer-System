`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 13:39:33
// Design Name: 
// Module Name: div8u_tst
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


module div8u_tst( );
 reg clk;
 reg rst_n;
 reg in_valid;
 reg [7:0] x;
 reg [3:0] y;
 wire [7:0] q;
 wire [3:0] r;
 wire out_valid;
 wire in_error;
 wire error;
 integer i,j;
//将模块名改为自己的待测模块
div8u_res 
div_impl(.clk(clk),.rst_n(rst_n),.x(x),.y(y),.in_valid(in_valid),.q(q),.r(r),.out_valid(out_valid),.in_error(in_error));
div_u_check dic_c(.x(x),.y(y),.valid(out_valid),.q(q),.r(r),.in_error(in_error),.error(error));
always
# 5 clk=~clk;
always @(posedge clk) begin
 if(error == 1) begin
 $display("error here\n");
 $stop;
 end
end
initial begin
 clk = 1'b0;
 rst_n = 1'b0;
 in_valid = 1'b0;
 #10 rst_n = 1;
 for(i = 255;i >=0;i = i-23)begin //可修改被除数的步长
 for(j = 15;j>= 0;j = j-3) begin //可修改除数的步长
 #5 x = i;y = j;in_valid = 1'b1;
 #5 in_valid = 1'b0;
 #150 ;
 end
 end
 $stop;
end
endmodule
//除法验证
module div_u_check( 
 input [7:0]x,
 input [3:0]y,
 input valid,
 input [7:0]q,
 input [3:0]r,
 input in_error,
 output error
);
 wire inerror_;
 wire [7:0] q_;
 wire [3:0] r_;
 assign q_ = x/y; //使用 Verilog 除法运算生成商
 assign r_ = x-y*q; //使用 Verilog 乘法运算生成余数
 assign inerror_ = x == 0 || y == 0;
 assign error = ~(valid == 0 || (valid == 1 && q_ == q && r_ == r)) || (in_error != inerror_);
endmodule
