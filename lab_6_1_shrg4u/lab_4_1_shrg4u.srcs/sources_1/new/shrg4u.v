`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 08:12:21
// Design Name: 
// Module Name: shrg4u
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


module shrg4u(
    input CLK, CLR, S0, S1, RIN, LIN, A, B, C, D,
    output reg QA, QB, QC, QD
    );
    always @ (posedge CLK) begin
        if (CLR) begin QA <= 0; QB <= 0; QC <= 0; QD <= 0; end
        else case ({S1, S0})
            2'b01: begin QA <= RIN; QB <= QA; QC <= QB; QD <= QC; end
            2'b10: begin QA <= QB; QB <= QC; QC <= QD; QD <= LIN; end
            2'b11: begin QA <= A; QB <= B; QC <= C; QD <= D; end
        endcase
    end
endmodule
