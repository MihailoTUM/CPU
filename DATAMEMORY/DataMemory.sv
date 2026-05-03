
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

    // temporarly
    assign dataMemoryResult = 16'hXXXX;

    PipelineRegisterDM pipelineRegister(
        .clk(clk),
        .ALUResult(ALUResult),
        .writeBackDst(writeBackALUResultDst),
        .writeBackEnable(writeBackEnable),
        .operation(operation),
        // outputs
        .result(),
        .dst(dstToWriteBack),
        .enableSignal(enableToWriteBack)
    );

    // memory, takes 10-more cycles to operate
    Memory mem();

    always_comb 
    begin
        case(operation)
        4'hE: resultToWriteBack = dataMemoryResult;
        4'hF: resultToWriteBack = dataMemoryResult;
        default: resultToWriteBack = ALUResult;
        endcase
    end

endmodule