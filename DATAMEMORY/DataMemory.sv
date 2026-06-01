
module DataMemory(
    input logic clk,
    input logic hold,
    input logic flush,

    input logic [15:0] inALUDataResult,
    input logic [3:0] inWriteBackDataResultDst,
    input logic inWriteBackDataResultEnable,
    input logic [3:0] inOperation,
    input logic [15:0] inMemoryAddress,

    output logic outHoldSignalFromDataMemory,

    output logic [15:0] outDataResult,
    output logic [3:0] outWriteBackDataResultDst,
    output logic outWriteBackDataResultEnable,

    output logic [15:0] forwardPathFromDataMemory,
    output logic [3:0] forwardPathFromDataMemorySrc
);
    logic [15:0] localALUDataResult;
    logic [3:0] localOperation;
    logic [15:0] localMemoryAddress;
    logic [3:0] localWriteBackDataResultDst;

    logic [15:0] localDataMemoryResult;


    PipelineRegisterDM pipelineRegister(
        .clk(clk),
        .hold(hold),
        .flush(flush),

        .inALUDataResult(inALUDataResult),
        .inWriteBackDataResultDst(inWriteBackDataResultDst),
        .inWriteBackDataResultEnable(inWriteBackDataResultEnable),
        .inOperation(inOperation),
        .inMemoryAddress(inMemoryAddress),

        .outALUDataResult(localALUDataResult),
        .outWriteBackDataResultDst(localWriteBackDataResultDst),
        .outWriteBackDataResultEnable(outWriteBackDataResultEnable),
        .outOperation(localOperation),
        .outMemoryAddress(localMemoryAddress)
    );

    always_comb
        begin
            case(localOperation)
                4'hE: outHoldSignalFromDataMemory = 1;

                default: outHoldSignalFromDataMemory = 0;
            endcase
        end

    assign forwardPathFromDataMemory = localALUDataResult;
    assign forwardPathFromDataMemorySrc = localWriteBackDataResultDst;
    assign outWriteBackDataResultDst = localWriteBackDataResultDst;

    logic localWriteToMemoryEnable;
    assign localWriteToMemoryEnable = (localOperation == 4'hE);

    Memory memory(
        .clk(clk),
        .inWriteToMemoryEnable(localWriteToMemoryEnable),

        .inALUDataResult(localALUDataResult),
        .inMemoryAddress(localMemoryAddress),

        .outDataMemoryResult(localDataMemoryResult)
    );


    always_comb 
    begin
        case(localOperation)
        4'hD: outDataResult = localDataMemoryResult;
        4'hE: outDataResult = localDataMemoryResult;
        default: outDataResult = localALUDataResult;
        endcase
    end

endmodule