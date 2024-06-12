`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 10:41:50
// Design Name: 
// Module Name: CPU_data_channel
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


module CPU_data_channel (
    input clk,
    input rst
);

    wire [31:0] PCout, PCin, instr, PCnxt, ALUa, ALUb, ALUout, ADD2_B, ADD2_out, SigExt_out, data_W, data_R, WriteData_RF;
    wire [31:0] MUX_2_32_1_out;
    reg RegWr, ExtOp, ALUASrc, ALUBSrc, NxtASrc, NxtBSrc, Branch, MemWr, MemOp, MemToReg;
    wire [2:0] ALUCtr;
    wire [4:0] W_Reg;
    wire [27:0] SHL2_out28;

    PC pc(clk, rst, PCin, PCout);

    assign PCnxt = PCout + 4;
//ADD ADD1(.A(PC_out),.B(PC_out),.Out(Add1_out));
    
    always @ (*) begin
        case (instr[6:0])
            7'b0000011: {}
            {MemRd,MemWr,ALUOp,ALUSrc,RegDst,RegWr,Branch,Jump,MemtoReg}={10'b1000101001};
        endcase
    end
    
MCU MCU(.MemRd(MemRd),.MemWr(MemWr),.ALUOp(ALUOp),.ALUSrc(ALUSrc),.RegDst(RegDst),.RegWr(RegWr),.Branch(Branch),.Jump(Jump),.MemtoReg(MemtoReg),
	.In(Inst[31:26]));

SHL2_26 SHL2_26(.In(Inst[25:0]),.Out(SHL2_out28));

ALU_CU ALU_CU(.ALUop(ALUOp),.FuncCode(Inst[5:0]),.Out(ALUctl));

ALU ALU(.ALUctl(ALUctl),.A(ALU_A),.B(ALU_B),.ALUout(ALU_out),.Zero(Zero));

ADD ADD2(.A(Add1_out),.B(ADD2_B),.Out(ADD2_out));

SigExt16_32 SigExt16_32(.In(Inst[15:0]),.Out(SigExt_out));

SHL2_32 SHL2_32(.In(SigExt_out),.Out(ADD2_B));

mem_ins mem_ins(.addr(PC_out),.ins(Inst));

mem_data mem_data(.ena_W(MemWr),.ena_R(MemRd),.addr(ALU_out),.data_W(data_W),.data_R(data_R),.clock(clock));

reg_file reg_file(.Read1(Inst[25:21]),.Read2(Inst[20:16]),.WriteReg(W_Reg),
		.WriteData(WriteData_RF),.RegWr(RegWr),.Data1(ALU_A),.Data2(data_W),.clock(clock));

ANDgate ANDgate(.in1(Branch),.in2(Zero),.Out(ANDgate_out));

MUX_2_5 MUX_2_5(.in0(Inst[20:16]),.in1(Inst[15:11]),.Sel(RegDst),.Out(W_Reg));

MUX_2_32 MUX_2_32_1(.in0(Add1_out),.in1(ADD2_out),.Sel(ANDgate_out),.Out(MUX_2_32_1_out));

MUX_2_32 MUX_2_32_2(.in0(MUX_2_32_1_out),.in1({Add1_out[31:28],SHL2_out28[27:0]}),.Sel(Jump),.Out(PC_in));

MUX_2_32 MUX_2_32_3(.in0(data_W),.in1(SigExt_out),.Sel(ALUSrc),.Out(ALU_B));

MUX_2_32 MUX_2_32_4(.in0(ALU_out),.in1(data_R),.Sel(MemtoReg),.Out(WriteData_RF));

endmodule



    wire [31:0] PCout, PCin, instr, ALUa, ALUb, ALUout, 
    
    input [31:0] instr,
    input [2:0] ExtOp,
    input [2:0] MemOp,
    input [1:0] ALUASrc,
    input [3:0] ALUctr,
    input Branch,
    output dataout

    wire [6:0] op;
    wire [4:0] rs, rt, rd;
    wire [31:0] imm;
    assign op = instr[6:0];
    assign rs = instr[24:20];
    assign rt = instr[19:15];
    assign rd = instr[11:7];
    InstrToImm instrtoimm(instr, ExtOp, imm);
    
    wire [31:0] dataa, datab;
    wire zero;
    wire [31:0] result;
    always @ (*) begin
        case (ALUASrc)
            1'b0: 
        endcase
    end
    ALU alu(dataa, datab, ALUctr, zero, result);
    
    

endmodule
