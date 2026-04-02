

module CPU(
    input logic clk,
    input logic [15:0] instruction
);
    logic [15:0] localData;
    logic [3:0] localDestination;
    logic [3:0] localOpcode;
    logic [3:0] localWriteBackDst;

    logic [7:0] localImmediateOperand;

    logic [15:0] localA;
    logic [15:0] localB;

    Decode decode(
        .clk(clk),
        .instructionDecode(instruction),
        .dataDecode(localData),
        .dstDecode(localDestination),
        // outputs
        .aDecode(localA),
        .bDecode(localB),
        .opcodeDecode(localOpcode),
        .writeBackDstDecode(localWriteBackDst),
        .immediateOperandDecode(localImmediateOperand)
    );

    Execute execute(
        .clk(clk),
        .opcodeExecute(localOpcode),
        .dstExecute(localWriteBackDst),
        .srcAExecute(localA),
        .srcBExecute(localB),
        .iOperandExecute(localImmediateOperand),
        // outputs
        .dataExecute(localData),
        .writeBackDstExecute(localDestination)
    );


endmodule