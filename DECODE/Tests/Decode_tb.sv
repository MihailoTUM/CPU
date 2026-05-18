


module Decode_tb();
    logic clk;
    logic hold;

    logic [15:0] inInstructionAddress;
    logic [15:0] inInstruction;
    logic [15:0] inDataToStore;
    logic [3:0] inWriteBackDst;
    logic inEnableWrite;

    logic [3:0] outOperation;   
    logic [3:0] outDstAddress;
    logic [3:0] outSrc1Address;
    logic [3:0] outSrc2Address;
    logic [15:0] outSrc1Data;
    logic [15:0] outSrc2Data;
    logic [7:0] outImmediate;

    logic [15:0] outInstructionAddress;
    
    Decode dut(
        .clk(clk),
        .hold(hold),

        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),
        .inDataToStore(inDataToStore),
        .inWriteBackDst(inWriteBackDst),
        .inEnableWrite(inEnableWrite),

        .outOperation(outOperation),
        .outDstAddress(outDstAddress),
        .outSrc1Address(outSrc1Address),
        .outSrc2Address(outSrc2Address),
        .outSrc1Data(outSrc1Data),
        .outSrc2Data(outSrc2Data),
        .outImmediate(outImmediate),

        .outInstructionAddress(outInstructionAddress)
    );


    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Decode.vcd");
        $dumpvars(0, Decode_tb);

        /*  1.cycle

        */
        inInstruction = 16'h0008; inDataToStore = 16'hFFFF; inWriteBackDst = 4'hF; inEnableWrite = 1;
        #4;

        inInstruction = 16'hD1F2; inDataToStore = 16'hXXXX; inWriteBackDst = 4'hX; inEnableWrite = 1;
        #4;

        inInstruction = 16'hF1F2; inDataToStore = 16'hABCD; inWriteBackDst = 4'h5; inEnableWrite = 1;
        #4;

        inInstruction = 16'hA502; inDataToStore = 16'hXXXX; inWriteBackDst = 4'hX; inEnableWrite = 1;
        #4;

        hold = 1;
        #8;
        
        $finish;
    end

endmodule