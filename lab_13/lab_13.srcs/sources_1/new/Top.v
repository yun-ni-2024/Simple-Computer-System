`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/06 16:03:09
// Design Name: 
// Module Name: Top
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


module Top(
    input clk, rst,
    output [31:0] imemaddr, imemdataout,
    output imemclk,
    output [31:0] dmemaddr, dmemdataout, dmemdatain,
    output dmemrdclk, dmemwrclk,
    output [2:0] dmemop,
    output dmemwe,
    output [31:0] dbgdata
//    input segclk,
//    output [6:0] seg,
//    output [7:0] an
    );
    
    wire [31:0] Instr;
    wire [31:0] PCout;
    wire [31:0] Result, DataOut;
    
    reg InstrMemEn, InstrMemWr;
    reg MemEn;
    
    always @ (*) begin
        if (rst) begin
            InstrMemEn = 1;
            MemEn = 0;
            InstrMemWr = 0;
        end
        else begin
            InstrMemEn = 1;
            MemEn = 1;
            InstrMemWr = 0;
        end
    end
    
    InstrMem insmem(clk, InstrMemEn, InstrMemWr, PCout, Instr);
    
    wire[2:0] ExtOp;
    wire RegWr;
    wire ALUASrc;
    wire [1:0] ALUBSrc;
    wire [3:0] ALUctr;
    wire [2:0] Branch;
    wire MemtoReg;
    wire MemWr;
    wire [2:0] MemOp;
    Control ctrl(Instr, ExtOp, RegWr, ALUASrc, ALUBSrc, ALUctr, Branch, MemtoReg, MemWr, MemOp);
    wire [4:0] Rd, Rs1, Rs2;
    assign Rd = Instr[11:7];
    assign Rs1 = Instr[19:15];
    assign Rs2 = Instr[24:20];
    
    wire [31:0] dbg_rf1, dbg_rf2;//
    
    wire [31:0] BusA, BusB, BusW;
    RegFile rf(clk, Rs1, Rs2, Rd, BusW, RegWr, BusA, BusB, dbg_rf1, dbg_rf2);
    wire [31:0] Imm;
    InstrToImm instioimm(Instr, ExtOp, Imm);
    
    wire [31:0] ALUdataA, ALUdataB;
    MUX2 mux_alua(BusA, PCout, ALUASrc, ALUdataA);
    MUX3 mux_alub(BusB, Imm, 4, ALUBSrc, ALUdataB);
    wire Zero;
    ALU alu(ALUdataA, ALUdataB, ALUctr, Zero, Result);
    
    wire [31:0] dbg_mem;//
    
    DataMem datamem(clk, MemWr, MemEn, MemOp, Result, BusB, DataOut, dbg_mem);
    MUX2 mux_memtoreg(Result, DataOut, MemtoReg, BusW);
    
    wire NxtASrc, NxtBSrc;
    BranchControl branchctrl(Zero, Result[0], Branch, NxtASrc, NxtBSrc);
    wire [31:0] NxtA, NxtB;
    MUX2 mux_nxta(PCout, BusA, NxtASrc, NxtA);
    MUX2 mux_nxtb(4, Imm, NxtBSrc, NxtB);
    wire [31:0] PCnxt, PCin;
    Adder adder(NxtA, NxtB, PCnxt);
    MUX2 mux_pc(PCnxt, 0, rst, PCin);
    PCcount pc(clk, PCin, PCout);
    
//    always @ (posedge clk) $display("PC=%h Instr=%h ALUctr=%h a=%h b=%h Result=%h Zero=%h Imm=%h", PCout, Instr, ALUctr, ALUdataA, ALUdataB, Result, Zero, Imm);
    
    assign imemaddr = PCout;
    assign imemdataout = Instr;
    assign imemclk = clk;
    assign dmemaddr = Result;
    assign dmemdataout = DataOut;
    assign dmemdatain = BusB;
    assign dmemrdclk = clk;
    assign dmemwrclk = clk;
    assign dmemop = MemOp;
    assign dmemwe = MemWr;
    assign dbgdata = PCout;
    
//    wire [31:0] seg7data;
//    assign seg7data[7:0] = dbg_mem[7:0];
//    assign seg7data[15:8] = PCout[7:0];
//    assign seg7data[23:16] = dbg_rf1[7:0];
//    assign seg7data[31:24] = dbg_rf2[7:0];
//    seg7decimal seg7(seg7data, segclk, seg, an);
    
endmodule
