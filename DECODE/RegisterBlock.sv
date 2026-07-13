

module RegisterBlock(
    // control inputs
    input logic         clk,
    input logic         inDataResultSkippySignal,
    input logic         inWriteToRegisterEnable,

    // data inputs
    input logic [3:0]   inOperation,
    input logic [15:0]  inDataToStore,
    input logic [3:0]   inDstAddress,
    input logic [3:0]   inWriteBackDstAddress,
    input logic [3:0]   inData1Address,
    input logic [3:0]   inData2Address,
    input logic [7:0]   inImmediate,
    input logic [15:0]  inDataResultSkippy,

    // control outputs
    output logic        outWriteToRegisterEnable,
    output logic        outWriteToMemoryEnable,
    output logic        outDeactivateExecutePath,
    output logic        outDeactivateMemoryPath,

    // data outputs
    output logic [15:0] outData1,
    output logic [15:0] outData2,
    output logic [7:0]  outImmediate,
    output logic [3:0]  outDstAddress
);

    logic [15:0] registers [15:0];

    always_ff @(posedge clk)
    begin
        if(inWriteToRegisterEnable) registers[inWriteBackDstAddress] <= inDataToStore;

        if(inDataResultSkippySignal) registers[4'hE] <= inDataResultSkippy;
    end

    always_comb 
    begin
        case(inOperation)
        4'h8:
            begin
                outData1 = registers[inData1Address];
                outData2 = registers[inData2Address];
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
                outDstAddress = 4'hF;
                outDeactivateExecutePath = 1;
                outDeactivateMemoryPath = 1;
            end
        4'h9:
            begin
                outData1 = registers[inDstAddress];
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 1;
                outDeactivateMemoryPath = 1;
            end
        4'hA:
            begin
                outData1 = registers[inDstAddress];
                outData2 = 16'hXXXX;
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 1;
                outWriteToMemoryEnable = 0;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        4'hB:
            begin
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        4'hC:
            begin
                outData1 = registers[4'hE];
                outData2 = 16'hXXXX;
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        4'hD:
            begin
                outData1 = registers[inData1Address];
                outData2 = 16'hXXXX;
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 1;
                outWriteToMemoryEnable = 0;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        4'hE: 
            begin
                outData1 = registers[inDstAddress];
                outData2 = registers[inData1Address];
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 1;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        
        4'hF:
            begin
                outData1 = registers[inData1Address];
                outData2 = registers[inData2Address];
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
                outDstAddress = 4'hF;
                outDeactivateExecutePath = 1;
                outDeactivateMemoryPath = 1;
            end
        default: 
            begin
                outData1 = registers[inData1Address];
                outData2 = registers[inData2Address];
                outImmediate = inImmediate;
                outWriteToRegisterEnable = 1;
                outWriteToMemoryEnable = 1;
                outDstAddress = inDstAddress;
                outDeactivateExecutePath = 0;
                outDeactivateMemoryPath = 0;
            end
        endcase
    end

endmodule