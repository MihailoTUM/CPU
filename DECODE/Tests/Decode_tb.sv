


module Decode_tb();
    logic clk;
    logic [15:0] instruction;
    logic [15:0] dataToStore;
    logic [3:0] writeBackDst;
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [15:0] src1Data;
    logic [15:0] src2Data;
    logic [7:0] immediateOperandOutput;

    Decode dut(
        .clk(clk),
        // inputs
        .instruction(instruction),
        .dataToStore(dataToStore),
        .writeBackDst(writeBackDst),

        // outputs
        .operation(operation),
        .dstAddress(dstAddress),
        .src1Data(src1Data),
        .src2Data(src2Data),
        .immediateOperandOutput(immediateOperandOutput)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Decode.vcd");
        $dumpvars(0, Decode_tb);

        /*  1.cycle

        */
        instruction = 16'hXXXX; dataToStore = 16'hFFFF; writeBackDst = 4'h0;
        #4;

        instruction = 16'hXXXX; dataToStore = 16'hAAAA; writeBackDst = 4'h1;
        #4;

        instruction = 16'h0201; dataToStore = 16'hBBBB; writeBackDst = 4'h8;
        #4;

        $finish;
    end

endmodule