`ifndef Fetch_Cycle_V
`define Fetch_Cycle_V

`include "PC.v"
`include "Adder.v"
`include "Mux.v"
`include "Instruction_Memory.v"
`include "Mux_3_X_1.v"

module fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

input clk, rst, PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD, PCD, PCPlus4D;

wire [31:0] PC_F, PCF, PCPlus4F, InstrF;
reg [31:0] PCF_reg, PCPlus4F_reg, InstrF_reg;

    Mux PC_Mux(
               .a(PCPlus4F),
               .b(PCTargetE),
               .s(PCSrcE),
               .y(PC_F)
                );

    PC Program_Counter (
                .clk(clk),
                .rst(rst),
                .PC(PCF),
                .PC_Next(PC_F)
                );

    // Declare Instruction Memory
    Instruction_Memory IMEM (
                .rst(rst),
                .A(PCF),
                .RD(InstrF)
                );

    // Declare PC adder
    Adder PC_adder (
                .a(PCF),
                .b(32'h00000004),
                .c(PCPlus4F)
                );

    // Fetch Cycle Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end
    // Assigning Registers Value to the Output port
    assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;


endmodule
`endif