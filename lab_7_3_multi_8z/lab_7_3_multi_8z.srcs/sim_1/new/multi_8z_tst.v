`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/20 17:03:24
// Design Name: 
// Module Name: multi_8z_tst
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


module multi_8z_tst ( );
    reg [7:0] X, Y;
    wire [15:0] P;
    multi_8z UUT ( .x(X), .y(Y), .p(P) ); // Instantiate the UUT
//    initial begin
//        X = 5;
//        Y = 8;
//    end
    task checkP;
        input i, j, P;
        integer i, j, prod;
        reg [15:0] P;
        begin
            prod = i*j;
            if (P !== prod) begin
                $display($time," Error: i=%d, j=%d, expected %d (%16b), got %d (%16b)",
                i, j, prod, prod, P, P);
                $stop(1);
            end;
        end
    endtask
    initial begin : TB // Start testing at time 0
        integer i, j;
        for ( i=17; i<=255; i=i+19 ) //可修改 i 初始值和步长
        for ( j=13; j<=255; j=j+23 ) begin //可修改 j 初始值和步长
            X = i; Y = j;
            #5; // wait 10 ns, then check result
            checkP (i, j, P);
        end
        $display($time, " Test ended"); $stop(1); // end test
    end
endmodule
