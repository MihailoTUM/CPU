
module DataMemory(
    // control inputs
    input logic clk,

    // data inputs
    input logic [15:0] ALUResult,
    input logic [3:0] writeBackALUResultDst,
    input logic writeBackEnable,
    input logic [3:0] operation,
    input logic [15:0] inDataToStoreInMemory,

    // control outputs
    output logic enableToWriteBack,

    // data outputs
    output logic [15:0] resultToWriteBack,
    output logic [3:0] dstToWriteBack,

    // forward path
    output logic [15:0] forwardPathFromDataMemory,
    output logic [3:0] forwardPathFromDataMemorySrc
);
    logic [15:0] dataMemoryResult;
    logic [15:0] localALUResult;
    logic [3:0] localOperation;

    logic [15:0] localDataToStoreInMemory;

    PipelineRegisterDM pipelineRegister(
        .clk(clk),

        .ALUResult(ALUResult),
        .writeBackDst(writeBackALUResultDst),
        .writeBackEnable(writeBackEnable),
        .operation(operation),
        .inDataToStoreInMemory(inDataToStoreInMemory),

        .result(localALUResult),
        .dst(dstToWriteBack),
        .enableSignal(enableToWriteBack),
        .operationOut(localOperation),
        .outDataToStoreInMemory(localDataToStoreInMemory)
    );

    assign forwardPathFromDataMemory = localALUResult;
    assign forwardPathFromDataMemorySrc = dstToWriteBack;

    Memory memory(
        .clk(clk),
        .allowWriteToMemory(),

        .memoryAddress(localALUResult),
        .dataToStoreInMemory(localDataToStoreInMemory)

        .dataToLoad(dataMemoryResult)
    );

    always_comb 
    begin
        case(localOperation)
        4'hD: resultToWriteBack = dataMemoryResult;
        4'hE: resultToWriteBack = dataMemoryResult;
        default: resultToWriteBack = localALUResult;
        endcase
    end

endmodule