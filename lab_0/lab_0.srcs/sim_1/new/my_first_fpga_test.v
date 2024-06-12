`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/21 10:05:59
// Design Name: 
// Module Name: my_first_fpga_test
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


module my_first_fpga_test();
    wire f;
    reg a,b;
    my_first_fpga s0(.A(a),.B(b),.F(f));
    initial begin
        begin a=1'b0; b=1'b0; end
        #200
        begin a=1'b0; b=1'b1; end
        #200
        begin a=1'b1; b=1'b0; end
        #200
        begin a=1'b1; b=1'b1; end
        #200
        begin a=1'b0; b=1'b0; end
    end
endmodule
