

module RegisterBlock(
    // control inputs
    input logic clk,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inDataToStore,
    input logic [3:0] inDstAddress,
    input logic [3:0] inWriteBackDst,
    input logic [3:0] inSrc1Address,
    input logic [3:0] inSrc2Address,
    input logic [7:0] inImmediate,
    input logic inEnableWrite,

    input logic [15:0] inAddressToRET,
    input logic inAddressToRETSignal,

    // data outputs
    output logic [15:0] outSrc1Data,
    output logic [15:0] outSrc2Data,
    output logic [7:0] outImmediate
);

    logic [15:0] registers [15:0];

    always_ff @(posedge clk)
    begin
        if(inEnableWrite) registers[inWriteBackDst] <= inDataToStore;

        if(inAddressToRETSignal) registers[4'hE] <= inAddressToRET;
    end

    always_comb 
    begin
        case(inOperation)
        4'hA:
            begin
                outSrc1Data = registers[inDstAddress];
                outSrc2Data = 16'hXXXX;
                outImmediate = inImmediate;
            end
        4'hB:
            begin
                outImmediate = inImmediate;
            end
        4'hC:
            begin
                outSrc1Data = registers[4'hE];
                outSrc2Data = 16'hXXXX;
                outImmediate = inImmediate;
            end
        4'hD:
            begin
                outSrc1Data = registers[inSrc1Address];
                outSrc2Data = 16'hXXXX;
                outImmediate = inImmediate;
            end
        4'hE: 
            begin
                // 
                outSrc1Data = registers[inWriteBackDst];
                // register for base address
                outSrc2Data = registers[inSrc1Address];
                outImmediate = inImmediate;
            end

        default: 
            begin
            outSrc1Data = registers[inSrc1Address];
            outSrc2Data = registers[inSrc2Address];
            outImmediate = inImmediate;
            end
        endcase
    end

endmodule