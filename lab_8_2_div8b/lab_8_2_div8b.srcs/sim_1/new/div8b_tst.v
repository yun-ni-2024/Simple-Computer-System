`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 17:21:28
// Design Name: 
// Module Name: div8b_tst
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


module div8b_tst();
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
div8b 
div_impl(.clk(clk),.rst_n(rst_n),.x(x),.y(y),.in_valid(in_valid),.q(q),.r(r),.out_valid(out_valid),.in_error(in_error));
div_b_check dic_c(.x(x),.y(y),.valid(out_valid),.q(q),.r(r),.in_error(in_error),.error(error));
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
 for(i = 255;i >=0;i = i-23)begin
 for(j = 15;j>= 0;j = j-3) begin
 #5 x = i;y = j;in_valid = 1'b1;
 #5 in_valid = 1'b0;
 #150 ;
 end
 end
 $stop;
end
endmodule
module div_b_check(
input [7:0]x,
input [3:0]y,
input valid,
input [7:0]q,
input [3:0]r,
input in_error,
output error
);
wire inerror_;
reg [15:0] x_;
reg [15:0] mid_x;
wire [7:0] q_neg;
wire [3:0] y_neg;
assign q_neg = ~q + 1;
assign y_neg = ~y + 1;
assign inerror_ = x == 0 || y == 0;
assign error = ~(valid == 0 || (valid == 1 && x_[7:0] == x)) || (in_error != inerror_);
always@(*) begin
 if(q[7] == 1 && y[3] == 1) begin
 mid_x = q_neg * y_neg + {r[3],r[3],r[3],r[3],r[3:0]};
 x_ = mid_x;
 end
 else if(q[7] == 0 && y[3] == 1)begin
 mid_x = q * y_neg ;
 x_ = ~mid_x + 1 + {r[3],r[3],r[3],r[3],r[3:0]};
 end
 else if(q[7] == 1 && y[3] == 0)begin
 mid_x = q_neg * y;
 x_ = ~mid_x + 1 + {r[3],r[3],r[3],r[3],r[3:0]};
 end
 else begin
 mid_x = q * y + {r[3],r[3],r[3],r[3],r[3:0]};
 x_ = mid_x;
 end
end
endmodule
