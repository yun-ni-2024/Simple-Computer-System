`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/25 15:55:07
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
    
//    output reg [7:0] d1, d2, d3, d4,
    output [31:0] dbg_mem1, dbg_mem2, dbg_mem3, dbg_mem4,
    
    input [31:0] data2, addr2, data3, addr3
    );

//    reg [7:0] mem[8192:0];
//    reg [31:0] mem0[2043:0];
    reg [7:0] mem[4095:0];
    reg [31:0] mem0[1023:0];
//    reg [31:0] mem[8192:0];
    reg [31:0] input_mem[200:0];
    
    integer i;
    initial begin
        $readmemh("E:/vivado/lab_15/main_d.hex", mem0);
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i * 4] = mem0[i][7:0];
            mem[i * 4 + 1] = mem0[i][15:8];
            mem[i * 4 + 2] = mem0[i][23:16];
            mem[i * 4 + 3] = mem0[i][31:24];
        end
//        mem0[101] = 1; //addr=404
//        mem0[102] = 10;
//        mem0[103] = 100;
//        mem0[104] = 1000;
//        mem0[105] = 10000;
//        mem0[106] = 100000;
//        mem0[107] = 1000000;
//        mem0[108] = 10000000;
//        mem0[109] = 100000000;
//        mem0[110] = 1000000000;
//        mem[40] = 0;
//        mem[43] = 1;
//        mem[45] = 1;
//        mem[42] = 2;
//        mem[47] = 2;
//        mem[1540] = 0;
//        mem[1541] = 0;
//        mem[1542] = 0;
//        mem[1543] = 0;
//        mem0[385] = 0;
        for (i = 0; i < 200; i = i + 1) input_mem[i] = 0;
    end
    
    always @ (negedge clk) begin
        if (MemWr) begin
            if (MemOp == 3'b000) mem0[addr[19:0] / 4] <= DataIn;
            else mem[addr[19:0]] <= DataIn;
        end
        if (input_mem[addr3 - 32768] == data3)
            input_mem[addr2 - 32768] <= data2;
        else
            input_mem[addr3 - 32768] <= data3;
    end
    
    always @ (*) begin
        if (MemEn) begin
            if (addr[31:20] == 12'h002) begin
                if (MemOp == 3'b000) DataOut <= mem0[addr[19:0] / 4];
                else DataOut <= mem[addr[19:0]];
            end
            else DataOut <= input_mem[addr - 32768];
        end
    end
    
//    wire [31:0] dout;
//    DataMux datamux(d1, d2, d3, d4, MemOp, dout);
//    assign DataOut = addr[31:20] == 12'h002 ? (
//    {d4, d3, d2, d1}
//    ) : input_mem[(addr - 32768) / 4];
    
    assign dbg_mem1 = mem0[106];
    assign dbg_mem2 = input_mem[1];
    assign dbg_mem3 = input_mem[2];
    assign dbg_mem4 = input_mem[3];

/////////////
//    reg [7:0] mem [4095:0];
    
//    //For testing
//    integer i;
//    initial begin
////        for (i = 0; i < (1 << 10); i = i + 1) mem[i] = i;
        
//    end
//    //
    
////    always @ (negedge clk) begin
////        if (MemWr) case (MemOp)
////            3'b000: begin
////                mem[addr] <= DataIn[7:0];
////                mem[addr + 1] <= DataIn[15:8];
////                mem[addr + 2] <= DataIn[23:16];
////                mem[addr + 3] <= DataIn[31:24];
////            end
////            3'b001: begin
////                mem[addr] <= DataIn[7:0];
////            end
////            3'b010: begin
////                mem[addr] <= DataIn[7:0];
////                mem[addr + 1] <= DataIn[15:8];
////            end
////            3'b101: begin
////                mem[addr] <= DataIn[7:0];
////            end
////            3'b110: begin
////                mem[addr] <= DataIn[7:0];
////                mem[addr + 1] <= DataIn[15:8];
////            end
////            default: begin
            
////            end
////        endcase
////        else begin
        
////        end
////    end

//    always @ (negedge clk) begin
//        if (MemWr) begin
//            mem[addr] <= DataIn[7:0];
//        end
//    end
    
//    always @ (negedge clk) begin
//        if (MemWr && (MemOp == 3'b000 || MemOp == 3'b010 || MemOp == 3'b110)) begin
//            mem[addr + 1] <= DataIn[15:8];
//        end
//    end
    
////    always @ (negedge clk) begin
////        if (MemWr && MemOp == 3'b000) begin
////            mem[addr + 2] <= DataIn[23:16];
////        end
////    end
    
////    always @ (negedge clk) begin
////        if (MemWr && MemOp == 3'b000) begin
////            mem[addr + 3] <= DataIn[31:24];
////        end
////    end
    
//    always @ (*) begin
//        if (MemEn) case (MemOp)
//            3'b000: begin
//                DataOut = {mem[addr + 3][7:0], mem[addr + 2][7:0], mem[addr + 1][7:0], mem[addr][7:0]};
//            end
//            3'b001: begin
//                DataOut = {mem[addr][7] ? 24'hffffff : 24'h000000, mem[addr][7:0]};
//            end
//            3'b010: begin
//                DataOut = {mem[addr + 1][7] ? 16'hffff : 16'h0000, mem[addr + 1][7:0], mem[addr][7:0]};
//            end
//            3'b101: begin
//                DataOut = {24'h0000, mem[addr][7:0]};
//            end
//            3'b110: begin
//                DataOut = {16'h0000, mem[addr + 1][7:0], mem[addr][7:0]};
//            end
//            default: begin
            
//            end
//        endcase
//    end

endmodule
