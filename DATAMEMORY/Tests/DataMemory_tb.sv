`timescale 1ns/1ns

module DataMemory_tb();
    logic clk;
    logic [15:0] ALUResult;
    logic [3:0] writeBackALUResultDst;
    logic writeBackEnable;
    logic [3:0] operation;

    logic [15:0] resultToWriteBack;
    logic [3:0] dstToWriteBack;
    logic enableToWriteBack;

    DataMemory dut(
        .clk(clk),
        .ALUResult(ALUResult),
        .writeBackALUResultDst(writeBackALUResultDst),
        .writeBackEnable(writeBackEnable),
        .operation(operation),

        .resultToWriteBack(resultToWriteBack),
        .dstToWriteBack(dstToWriteBack),
        .enableToWriteBack(enableToWriteBack)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("DataMemory.vcd");
        $dumpvars(0, DataMemory_tb);
        
        ALUResult = 16'hABCD; writeBackALUResultDst = 4'h0; writeBackEnable = 1; operation = 4'h0;
        #12;

        ALUResult = 16'hFFFF; writeBackALUResultDst = 4'h1; writeBackEnable = 1; operation = 4'hE;
        #8;

        $finish;
    end

endmodule