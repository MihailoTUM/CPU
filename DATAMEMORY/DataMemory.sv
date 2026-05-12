
// data memory

module DataMemory(
    input logic clk,
    input logic [15:0] ALUResult,
    input logic [3:0] writeBackALUResultDst,
    input logic writeBackEnable,
    input logic [3:0] operation,

    output logic [15:0] resultToWriteBack,
    output logic [3:0] dstToWriteBack,
    output logic enableToWriteBack
);
    logic [15:0] dataMemoryResult;
    logic [15:0] localALUResult;
    logic [3:0] localOperation;

    // temporarly
    assign dataMemoryResult = 16'hXXXX;

    PipelineRegisterDM pipelineRegister(
        .clk(clk),
        .ALUResult(ALUResult),
        .writeBackDst(writeBackALUResultDst),
        .writeBackEnable(writeBackEnable),
        .operation(operation),
        // outputs
        .result(localALUResult),
        .dst(dstToWriteBack),
        .enableSignal(enableToWriteBack),
        .operationOut(localOperation)
    );

    // memory, takes 10-more cycles to operate
    Memory mem();

    always_comb 
    begin
        case(localOperation)
        4'hE: resultToWriteBack = dataMemoryResult;
        4'hF: resultToWriteBack = dataMemoryResult;
        default: resultToWriteBack = localALUResult;
        endcase
    end

endmodule