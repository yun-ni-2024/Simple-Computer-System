`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 16:41:35
// Design Name: 
// Module Name: shrg8u
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


module shrg8u(
    input CLK, CLR, S0, S1, RIN, LIN, A, B, C, D, E, F, G, H,
    output reg QA, QB, QC, QD, QE, QF, QG, QH
    );
    always @ (posedge CLK) begin
        if (CLR) begin
            QA <= 0; QB <= 0; QC <= 0; QD <= 0;
            QE <= 0; QF <= 0; QG <= 0; QH <= 0;
        end
        else case ({S1, S0})
            2'b01: begin
                QA <= RIN; QB <= QA; QC <= QB; QD <= QC;
                QE <= QD; QF <= QE; QG <= QF; QH <= QG;
            end
            2'b10: begin
                QA <= QB; QB <= QC; QC <= QD; QD <= QE;
                QE <= QF; QF <= QG; QG <= QH; QH <= LIN;
            end
            2'b11: begin
                QA <= A; QB <= B; QC <= C; QD <= D;
                QE <= E; QF <= F; QG <= G; QH <= H;
            end
        endcase
    end
endmodule
