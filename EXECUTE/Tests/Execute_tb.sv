`timescale 1ns/1ns

module Execute_tb();
    // control inputs
    logic clk;
    logic hold;

    // data inputs
    logic [3:0] inputOperation;
    logic [3:0] inputDstAddress;
    logic [3:0] inputSrc1Address;
    logic [3:0] inputSrc2Address;
    logic [15:0] inputSrc1;
    logic [15:0] inputSrc2;
    logic [7:0] inputImmediate;
    logic [15:0] forwardPathInput;
    logic [3:0] forwardPathSrcInput;

    // data outputs
    logic [15:0] out;
    logic [3:0] writeBackDst;
    logic enableWrite;
    logic [3:0] operation;
    logic controlHold;
    logic controlJump;
    logic [15:0] forwardPathOutput;
    logic [3:0] forwardPathSrcOutput;

    Execute dut(
        .clk(clk),
        .hold(hold),

        .inputOperation(inputOperation),
        .inputDstAddress(inputDstAddress),
        .inputSrc1Address(inputSrc1Address),
        .inputSrc2Address(inputSrc2Address),
        .inputSrc1(inputSrc1),
        .inputSrc2(inputSrc2),
        .inputImmediate(inputImmediate),
        .forwardPathInput(forwardPathInput),
        .forwardPathSrcInput(forwardPathSrcInput),

        .out(out),
        .writeBackDst(writeBackDst),
        .enableWrite(enableWrite),
        .operation(operation),
        .controlHold(controlHold),
        .controlJump(controlJump),
        .forwardPathOutput(forwardPathOutput),
        .forwardPathSrcOutput(forwardPathSrcOutput)
    );


    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        // loading #0A into register 0
        inputOperation = 4'h0; inputDstAddress = 4'h0; inputSrc1Address = 4'h0; inputSrc2Address = 4'h0; inputSrc1 = 16'h0000; inputSrc2 = 16'h0000; inputImmediate = 8'h0A; forwardPathInput = 16'h0000; forwardPathSrcInput = 4'h0;
        #4;

        // loading #01 into register 1
        inputOperation = 4'h0; inputDstAddress = 4'h1; inputSrc1Address = 4'h0; inputSrc2Address = 4'h0; inputSrc1 = 16'h0000; inputSrc2 = 16'h0000; inputImmediate = 8'h01; forwardPathInput = 16'h0000; forwardPathSrcInput = 4'h0;
        #4;

        // adding register 0 and register 1, store in register 2
        inputOperation = 4'h1; inputDstAddress = 4'h2; inputSrc1Address = 4'h0; inputSrc2Address = 4'h1; inputSrc1 = 16'h000A; inputSrc2 = 16'h0001; inputImmediate = 8'h00; forwardPathInput = 16'h0000; forwardPathSrcInput = 4'h0;
        #4;

        $finish;
    end

endmodule