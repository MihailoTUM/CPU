// include forward path

module ALU(
    // control inputs
    input logic clk,
    input logic hold,

    // data inputs
    input logic [3:0] operation,
    input logic [15:0] d1,
    input logic [15:0] d2,
    input logic [7:0] immediate,

    // data outputs
    output logic [15:0] out,
    output logic enableWrite,
    // output logic [15:0] forwardPathData,
    output logic [3:0] outputOperation,
    output logic controlHold,
    output logic [31:0] flags
);
    logic controlSignals;
    logic [15:0] quotient;
    logic [15:0] remainder;
    logic divFinished;

    ALUControl control(
        .clk(clk),
        .hold(hold),
        .operation(operation),
        .divFinished(divFinished),
        .controlSignals(controlSignals),
    );

    assign controlHold = controlSignals[2];

    logic reset;
    assign reset = controlSignals[3];
    DIV16 div16(clk, reset, d1, d2, quotient, remainder, divFinished);

    logic [15:0] constOut;
    logic [15:0] addOut;
    logic addCarry;
    logic [15:0] subOut;
    logic subCarry;
    // logic [15:0] andOut;
    // logic [15:0] orOut;
    // logic [15:0] xorOut;

    CONST16 const16(immediate, constOut);
    ADD16 add16(d1, d2, 1'b0, addOut, addCout);
    ADD16 sub16(d1, ~d2, 1'b1, subOut, subCout);
    // AND16 and16(data1, data2, andOut);
    // OR16 or16(data1, data2, orOut);
    // XOR16 xor16(data1, data2, xorOut);

    // single-cycle operation
    always_comb
    begin 
        case(operation)
            // arithmetic
            4'h0: out = constOut;
            4'h1: out = addOut;
            4'h2: out = subOut;

            // logic
            // 4'h5: result = andOut;
            // 4'h6: result = orOut;
            // 4'h7: result = xorOut;

            // (stall) NOP
            4'hF: out = 16'hXXXX;
            default: out = 16'hXXXX;
        endcase
    end

    /*
        further operations possibe like BRANCH possible
        BZ: if difference = 0
        BN: if MSB = 1
        BP: if MSB = 0
    */

    assign outputOperation = operation;
    assign enableWrite = ~(operation[3] & operation[2] & operation[1] & operation[0]);
    assign flags = { addCarry, subCarry, 30'b00_0000_0000_0000_0000_0000_0000_0000 };

endmodule