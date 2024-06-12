`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 09:50:41
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk,
    input MemWr, MemEn,
    input [2:0] MemOp,
    input [31:0] addr,
    input [31:0] DataIn,
    output reg [31:0] DataOut,
    output [31:0] dbg_mem
    );
    
//    blk_mem_gen_0 mem();
    
    reg [31:0] mem0[16383:0];
    
//    integer i;
//    initial begin
////        for (i = 1; i < 1024; i = i + 1) mem[i] = 0;
////        mem[0] = 5;
////        mem[1] = 32'h0007;
////        mem[2] = 32'h0002;
////        mem[3] = 32'h0004;
////        mem[4] = 32'h0000;
////        mem[5] = 32'h0007;
////        mem[6] = 32'h0008;
////        mem[7] = 32'h0009;
////        mem[8] = 32'h0001;
////        mem[9] = 32'h0036;
////        mem[10] = 32'h0003;
////        mem[11] = 32'h005b;
//    end
    
//    always @ (posedge clk) begin
//        if (MemWr) begin mem[addr] <= DataIn;
////        $display("fuck:%h %h", addr, DataIn);
//        end
//    end
    
//    always @ (*) begin
//        if (MemEn) DataOut = mem[addr];
//        else DataOut = 0;
//    end
    
//    assign dbg_mem = mem[4];
/////////////
    reg [7:0] mem [65535:0];
    
    //For testing
    integer i;
    initial begin
//        for (i = 0; i < (1 << 10); i = i + 1) mem[i] = i;
        
    end
    //
    
    always @ (negedge clk) begin
        if (MemWr) case (MemOp)
            3'b000: begin
                mem[addr] <= DataIn[7:0];
                mem[addr + 1] <= DataIn[15:8];
                mem[addr + 2] <= DataIn[23:16];
                mem[addr + 3] <= DataIn[31:24];
            end
            3'b001: begin
                mem[addr] <= DataIn[7:0];
            end
            3'b010: begin
                mem[addr] <= DataIn[7:0];
                mem[addr + 1] <= DataIn[15:8];
            end
            3'b101: begin
                mem[addr] <= DataIn[7:0];
            end
            3'b110: begin
                mem[addr] <= DataIn[7:0];
                mem[addr + 1] <= DataIn[15:8];
            end
        endcase
    end
    
    always @ (negedge clk) begin
        if (MemEn) case (MemOp)
            3'b000: begin
                DataOut = {mem[addr + 3][7:0], mem[addr + 2][7:0], mem[addr + 1][7:0], mem[addr][7:0]};
            end
            3'b001: begin
                DataOut = {mem[addr][7] ? 24'hffffff : 24'h000000, mem[addr][7:0]};
            end
            3'b010: begin
                DataOut = {mem[addr + 1][7] ? 16'hffff : 16'h0000, mem[addr + 1][7:0], mem[addr][7:0]};
            end
            3'b101: begin
                DataOut = {24'h0000, mem[addr][7:0]};
            end
            3'b110: begin
                DataOut = {16'h0000, mem[addr + 1][7:0], mem[addr][7:0]};
            end
        endcase
    end
    
//    reg [7:0] d1, d2, d3, d4;
    
//    always @ (*) begin
//        if (MemEn) begin
//            d1 = mem[addr[19:0]];
//            d2 = mem[addr[19:0] + 1];
//            d3 = mem[addr[19:0] + 2];
//            d4 = mem[addr[19:0] + 3];
//        end
//    end
    
//    assign DataOut =
//    MemOp == 3'b000 ? {d4, d3, d2, d1} :
//    MemOp == 3'b001 ? {d1[7] ? 24'hffffff : 24'h000000, d1} :
//    MemOp == 3'b010 ? {d2[7] ? 16'hffff : 16'h0000, d2, d1} :
//    MemOp == 3'b101 ? {24'h000000, d1} :
//    {16'h0000, d2, d1};

endmodule
