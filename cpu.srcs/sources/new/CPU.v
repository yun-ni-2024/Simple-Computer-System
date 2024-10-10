`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 15:50:41
// Design Name: 
// Module Name: CPU
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


module CPU(
    input CLK100MHZ,  
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] AN,
    output [6:0] HEX,
    input  BTNC,
    input  PS2_CLK,
    input  PS2_DATA,
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS
//    output [31:0] imemaddr, imemdataout,
//    output imemclk,
//    output [31:0] dmemaddr, dmemdataout, dmemdatain,
//    output dmemrdclk, dmemwrclk,
//    output [2:0] dmemop,
//    output dmemwe,
//    output [31:0] dbgdata
//    input segclk,
//    output [6:0] seg,
//    output [7:0] an
    );
    
    reg CPUclk, segclk, iptclk;
    reg [31:0] cnt;
//    clk_wiz_1 mycpu_clk(.clk_in1(CLK100MHZ),.reset(BTNC),.locked(0),.clk_out1(CPUclk));
    initial begin
        cnt <= 0;
        CPUclk <= 0;
        segclk <= 0;
        iptclk <= 0;
    end
    always @ (posedge CLK100MHZ) begin
        cnt <= cnt + 1;
        CPUclk <= cnt[10];
        segclk <= cnt[5];
        iptclk <= cnt[15];
    end
    
    wire [31:0] Instr;
    wire [31:0] PCout;
    wire [31:0] Result, DataOut;
    
    reg InstrMemEn, InstrMemWr;
    reg MemEn;
    
    wire stop;
    reg rst;
    initial begin
        rst = 1;
    end
    
    always @ (*) begin
        if (rst) begin
            InstrMemEn = 1;
            MemEn = 1;
            InstrMemWr = 0;
        end
        else begin
            InstrMemEn = 1;
            MemEn = 1;
            InstrMemWr = 0;
        end
    end
    
    wire [31:0] dbg_ins; //
    
    InstrMem insmem(InstrMemEn, InstrMemWr, PCout, Instr, dbg_ins);
//    always @ (negedge CPUclk) begin
//        if (stop) rst = 1;
//    end
    
    wire[2:0] ExtOp;
    wire RegWr;
    wire ALUASrc;
    wire [1:0] ALUBSrc;
    wire [3:0] ALUctr;
    wire [2:0] Branch;
    wire MemtoReg;
    wire MemWr;
    wire [2:0] MemOp;
    Control ctrl(Instr, ExtOp, RegWr, ALUASrc, ALUBSrc, ALUctr, Branch, MemtoReg, MemWr, MemOp, stop);
    wire [4:0] Rd, Rs1, Rs2;
    assign Rd = Instr[11:7];
    assign Rs1 = Instr[19:15];
    assign Rs2 = Instr[24:20];
    
    wire [31:0] dbg_rf1, dbg_rf2, dbg_rf3;//
    
    wire [31:0] BusA, BusB, BusW;
    RegFile rf(CPUclk, Rs1, Rs2, Rd, BusW, RegWr, BusA, BusB, dbg_rf1, dbg_rf2, dbg_rf3);
    wire [31:0] Imm;
    InstrToImm instioimm(Instr, ExtOp, Imm);
    
    wire [31:0] ALUdataA, ALUdataB;
    MUX2 mux_alua(BusA, PCout, ALUASrc, ALUdataA);
    MUX3 mux_alub(BusB, Imm, 4, ALUBSrc, ALUdataB);
    wire Zero;
    ALU alu(ALUdataA, ALUdataB, ALUctr, Zero, Result);
    
    wire [31:0] dbg_mem1, dbg_mem2, dbg_mem3, dbg_mem4;//
    
    wire datawe;
    assign datawe = Result[31:20] == 12'h002 ? MemWr : 1'b0;
    reg [31:0] vga_addr, vga_datain;
    reg vga_we;
    
    reg [31:0] seg7data;
    
    initial begin
        vga_we <= 0;
    end
    always @ (negedge CPUclk) begin
        if (MemWr && Result[31:20] == 12'h001) begin
//            seg7data[15:8] <= BusB;
            
            vga_we <= 1;
            vga_addr <= Result[19:0];
            vga_datain <= BusB;
        end
        else vga_we <= 0;
    end
    reg [31:0] data2, addr2, data3, addr3;
    reg [7:0] keyram [100:0];
    DataMem datamem(CPUclk, datawe, MemEn, MemOp, Result, BusB, DataOut, dbg_mem1, dbg_mem2, dbg_mem3, dbg_mem4, data2, addr2, data3, addr3);
    MUX2 mux_memtoreg(Result, DataOut, MemtoReg, BusW);
    
    wire NxtASrc, NxtBSrc;
    BranchControl branchctrl(Zero, Result[0], Branch, NxtASrc, NxtBSrc);
    wire [31:0] NxtA, NxtB;
    MUX2 mux_nxta(PCout, BusA, NxtASrc, NxtA);
    MUX2 mux_nxtb(4, Imm, NxtBSrc, NxtB);
    wire [31:0] PCnxt, PCin;
    Adder adder(NxtA, NxtB, PCnxt);
    MUX2 mux_pc(PCnxt, 0, rst, PCin);
    PCcount pc(CPUclk, PCin, PCout);
    
//    always @ (posedge clk) $display("PC=%h Instr=%h ALUctr=%h a=%h b=%h Result=%h Zero=%h Imm=%h", PCout, Instr, ALUctr, ALUdataA, ALUdataB, Result, Zero, Imm);
    
//    assign imemaddr = PCout;
//    assign imemdataout = Instr;
//    assign imemclk = clk;
//    assign dmemaddr = Result;
//    assign dmemdataout = DataOut;
//    assign dmemdatain = BusB;
//    assign dmemrdclk = clk;
//    assign dmemwrclk = clk;
//    assign dmemop = MemOp;
//    assign dmemwe = MemWr;
//    assign dbgdata = PCout;
    

    wire clk_25m;
    clk_wiz_0 my25m_clk(.clk_in1(CLK100MHZ),.reset(SW[0]),.locked(LED[0]),.clk_out1(clk_25m));
    
    reg [6:0] keyram_count;
    reg [12:0] key_curcount;
    integer i;
    initial begin
        key_curcount <= 0;
        keyram_count <= 0;
        for (i = 0; i < 80; i = i + 1) keyram[i] <= 0;
    end
    wire [7:0] h, m, s;
    digitalclk(CLK100MHZ, BTNC, h, m, s);
//    always @ (posedge iptclk) begin
//        case (cnt / 32768 % 100)
//            0: begin
//                addr2 <= 32'h00008000;
//                data2 <= keyram[0];
//            end
//            90: begin
//                addr2 <= 32'h000080f0;
//                data2 <= h;
//            end
//            91: begin
//                addr2 <= 32'h000080f4;
//                data2 <= m;
//            end
//            92: begin
//                addr2 <= 32'h000080f8;
//                data2 <= s;
//            end
//            default: begin
//                if (cnt / 32768 % 100 < 80) begin
//                    addr2 <= 32'h00008000 + (cnt / 32768 % 100) * 4;
//                    data2 <= keyram[cnt / 32768 % 100];
////                    data2 <= 1'b1;
//                end
//            end
//        endcase
//    end
    
    wire [7:0] key_ascii;
    wire [12:0] key_count;
    inoutlab my_keyboard(clk_25m, PS2_CLK, PS2_DATA, 0, key_ascii, key_count);

    
    reg flag;
    reg [31:0] fibnum, fibans;
    always @(negedge clk_25m) begin
//        seg7data[7:0] <= keyram_count;
//        seg7data[15:8] <= key_ascii;
        if (key_curcount != key_count) begin
            if (key_ascii == 13) begin
//                //hello
//                if (keyram_count == 5 && keyram[0] == 104 && keyram[1] == 101 && keyram[2] == 108 && keyram[3] == 108 && keyram[4] == 111) begin
//                    seg7data[31:24] <= 1;
//                end
//                //time
//                else if (keyram_count == 4 && keyram[0] == 116 && keyram[1] == 105 && keyram[2] == 109 && keyram[3] == 101) begin
//                    seg7data[31:24] <= 2;
//                end
//                //fib
//                else if (keyram_count >= 5 && keyram[0] == 102 && keyram[1] == 105 && keyram[2] == 98 && keyram[3] == 32) begin
//                    flag = 1;
//                    fibnum = 0;
//                    for (i = 4; i < keyram_count; i = i + 1) begin
//                        if (keyram[i] >= 48 && keyram[i] <= 57) begin
//                            fibnum = fibnum * 10 + keyram[i] - 48;
//                        end
//                        //other
//                        else flag = 0;
//                    end
                    
//                    //fib
//                    if (flag == 1) begin
//                        seg7data[31:24] <= 3;
//                        seg7data[23:16] <= fibnum;
//                    end
//                    //other
//                    else begin
//                        seg7data[31:24] <= 4;
//                    end
//                end
//                //other
//                else begin
//                    seg7data[31:24] <= 4;
//                end
                keyram[keyram_count] <= 0;
                keyram_count <= 0;
                key_curcount <= key_count;
                rst <= 0;
                
                addr2 <= 32768 + keyram_count;
                data2 <= 0;
            end
            else if (key_ascii == 8) begin
                keyram_count <= keyram_count - 1;
                key_curcount <= key_count;
            end
            else begin
                keyram[keyram_count] <= key_ascii;
                keyram_count <= keyram_count + 1;
                key_curcount <= key_count;
                
                addr2 <= 32768 + keyram_count;
                data2 <= key_ascii;
            end
        end
        else begin
            if (stop) rst = 1;
            if (cnt % 10000000 >= 0 && cnt % 10000000 <= 10000) case (cnt % 9)
                0: begin addr3 <= 32896; data3 <= h; end
                1: begin addr3 <= 32900; data3 <= m; end
                2: begin addr3 <= 32904; data3 <= s; end
                3: begin addr3 <= 32908; data3 <= (h / 10) + 48; end
                4: begin addr3 <= 32912; data3 <= (h % 10) + 48; end
                5: begin addr3 <= 32916; data3 <= (m / 10) + 48; end
                6: begin addr3 <= 32920; data3 <= (m % 10) + 48; end
                7: begin addr3 <= 32924; data3 <= (s / 10) + 48; end
                8: begin addr3 <= 32928; data3 <= (s % 10) + 48; end
                default: begin end
            endcase
        end
    end
    
    wire valid;
    vga my_vga_top(clk_25m, SW, LED, BTNC, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, valid, key_ascii, key_count, vga_we, vga_addr, vga_datain);
    
endmodule
