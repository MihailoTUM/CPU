

module CPU(
    input logic clk,
    input logic reset
);
    logic [15:0] instructionAddress;
    logic [15:0] dataAddress;

    logic [15:0] instruction;
    logic [15:0] dataOutput;

    Control Control(
        .clk(clk),
        .reset(reset),
        .instructionAddress(instructionAddress)
    );

    DRAM dram(
        .clk(clk),
        .writeEnable(1'b1),
        .instructionAddress(instructionAddress),
        .dataAddress(dataAddress),
        .dataOuput(dataOutput)
        .instructionOutput(instruction)
    );

    Registerblock Registerblock(
        .clk(clk),
        .reset(reset),
        .we(1'b1),
        .dst(instruction[11:8]),
        .source1(instruction[7:4]),
        .source2(instruction[3:0]),
        .dataIn(out),
        .out1(a),
        .out2(b)
    );

    ALU ALU(
        .instruction(),
        .inputALU1(),
        .inputALU2(),
        .outputALU(),
        .flag(flag)
    );

endmodule