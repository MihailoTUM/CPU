
// data memory

module DataMemory(
    input logic clk,
    input logic [15:0] ALUResult
    input logic [3:0] writeBackALUResultDst
    input logic writeBackEnable,
    input logic [3:0] operation,
    output logic [15:0] resultToWriteBack
    output logic [3:0] dstToWriteBack,
    output logic enableToWriteBack
);
    logic [15:0] localResult;
    logic [3:0] writeBackDst;
    logic localEnable;
    logic [15:0] dataMemoryResult;

    PipelineRegisterDM pipelineRegister(
        .clk(clk),
        .ALUResult(ALUResult),
        .writeBackDst(writeBackALUResultDst),
        .writeBackEnable(writeBackEnable),
        .operation(operation),
        // outputs
        .result(localResult),
        .dst(writeBackDst),
        .enableSignal(localEnable)
    );

    always_comb 
    begin
        case(operation)
        4'hE: resultToWriteBack = dataMemoryResult;
        4'hF: resultToWriteBack = dataMemoryResult;
        default: resultToWriteBack = ALUResult;
        endcase
    end

    /*
    check if load or store, if not, skip the memory
    */

endmodule