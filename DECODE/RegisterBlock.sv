

module RegisterBlock(
    // control inputs
    input logic clk,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inDataToStore,
    input logic [3:0] inWriteBackDst,
    input logic [3:0] inSrc1Address,
    input logic [3:0] inSrc2Address,
    input logic [7:0] inImmediate,
    input logic inEnableWrite,

    // data outputs
    output logic [15:0] outSrc1Data,
    output logic [15:0] outSrc2Data,
    output logic [7:0] outImmediate
);

    logic [15:0] registers [15:0];
    logic [4:0] stackPointerAddress;
    assign stackPointerAddress = 4'hF;

    always_ff @(posedge clk)
    begin
        if(inEnableWrite) registers[inWriteBackDst] <= inDataToStore;
    end

    always_comb 
    begin
        case(inOperation)
        4'hA:
            begin
                outSrc1Address = register[inWriteBackDst];
                outSrc2Address = 16'hXXXX;
                outImmediate = inImmediate;
            end
        4'hD:
            begin
                outSrc1Data = register[inSrc1Address];
                outSrc2Data = 16'hXXXX;
                immediate = inImmediate;
            end
        4'hE: 
            begin
                // 
                outSrc1Data = register[inWriteBackDst];
                // register for base address
                outSrc2Data = register[inSrc1Address];
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