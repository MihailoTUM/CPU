9
module DataMemory(
    input logic         clk,
    input logic         reset,
    input logic         hold,
    input logic         flush,

    input logic [15:0]  inDataResult,
    input logic [3:0]   inWriteBackDataResultDst,
    input logic         inWriteBackDataResultEnable,
    input logic [3:0]   inOperation,
    input logic [15:0]  inMemoryAddress,
    input logic         inWriteToMemoryEnable,

    output logic        outHoldFromDataMemory,

    output logic [15:0] outDataResult,
    output logic [3:0]  outWriteBackDataResultDst,
    output logic        outWriteBackDataResultEnable,

    output logic [15:0] forwardPathFromDataMemory,
    output logic [3:0]  forwardPathFromDataMemorySrc
);  
    logic [15:0]        localDataResult;
    logic [3:0]         localOperation;
    logic [15:0]        localMemoryAddress;
    logic [3:0]         localWriteBackDataResultDst;

    logic [15:0]        localDataMemoryResult;
    logic               localWriteToMemoryEnable;


    assign localWriteToMemoryEnable = (localOperation == 4'hE);

    PipelineRegisterDM pipelineRegister(
        .clk(clk),
        .reset(reset),
        .hold(hold),
        .flush(flush),

        .inDataResult(inDataResult),
        .inWriteBackDataResultDst(inWriteBackDataResultDst),
        .inWriteBackDataResultEnable(inWriteBackDataResultEnable),
        .inOperation(inOperation),
        .inMemoryAddress(inMemoryAddress),

        .outDataResult(localDataResult),
        .outWriteBackDataResultDst(localWriteBackDataResultDst),
        .outWriteBackDataResultEnable(outWriteBackDataResultEnable),
        .outOperation(localOperation),
        .outMemoryAddress(localMemoryAddress)
    );

    assign forwardPathFromDataMemory = localDataResult;
    assign forwardPathFromDataMemorySrc = localWriteBackDataResultDst;
    assign outWriteBackDataResultDst = localWriteBackDataResultDst;


    Memory memory(
        .clk(clk),
        .inWriteToMemoryEnable(localWriteToMemoryEnable),

        .inALUDataResult(localDataResult),
        .inMemoryAddress(localMemoryAddress),

        .outDataMemoryResult(localDataMemoryResult)
    );


    always_comb 
    begin
        case(localOperation)
        4'hD: outDataResult = localDataMemoryResult;
        4'hE: outDataResult = localDataMemoryResult;
        default: outDataResult = localDataResult;
        endcase
    end

endmodule