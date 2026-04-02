`timescale 1ns/1ns

// instruction: opcode/dst/src1/src2

module PipelineRegister_tb();
    logic clk;
    logic [15:0] instruction;
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [3:0] src1Address;
    logic [3:0] src2Address;
    logic [7:0] immediateOperand;

    PipelineRegister dut(
        .clk(clk),
        .instruction(instruction),
        .operation(operation),
        .dstAddress(dstAddress),
        .src1Address(src1Address),
        .src2Address(src2Address),
        .immediateOperand(immediateOperand)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("PipelineRegister.vcd");
        $dumpvars(0, PipelineRegister_tb);

        // first cycle
        instruction = 16'h0210;
        // wait one cycle
        #4;

        // second cycle
        instruction = 16'h0321;
        // wait one cycle
        #4;

        $finish;
    end
endmodule