// include forward path

module ALU(
    // control inputs
    input logic clk,
    // data inputs
    input logic [3:0] operation,
    input logic [3:0] dstAddress,
    input logic [15:0] d1,
    input logic [15:0] d2,
    input logic [7:0] immediate,

    // forward path
    input logic [15:0] forwardPathInput,
    input logic [3:0] forwardPathInputSrc,
    input logic [3:0] forwardSrc1Address,
    input logic [3:0] forwardSrc2Address,

    // data outputs
    output logic [15:0] out,
    output logic enableWrite,
    output logic [3:0] outputOperation,
    output logic controlHold,
    output logic [31:0] flags
);
    logic [15:0] localData1Output;
    logic [15:0] localData2Output;

    logic [3:0] controlSignals;
    logic [15:0] quotient;
    logic [15:0] remainder;
    logic divFinished;

    ALUControl control(
        .clk(clk),
        .divFinished(divFinished),
        .operation(operation),
        .dstAddress(dstAddress),
        .data1Input(d1),
        .data2Input(d2),
        
        .forwardPathInput(forwardPathInput),
        .forwardPathInputSrc(forwardPathInputSrc),
        .forwardPathSrc1Address(forwardPathSrc1Address),
        .forwardPathSrc2Address(forwardPathSrc2Address),
        
        .controlSignals(controlSignals),
        .data1Output(localData1Output),
        .data2Output(localData2Output)
    );

    logic [15:0] constOut;

    logic [15:0] addOut;
    logic addCarry;

    logic [15:0] subOut;
    logic subCarry;

    logic [15:0] mulOut;

    CONST16 const16(immediate, constOut);
    ADD16 add16(localData1Output, localData2Output, 1'b0, addOut, addCout);
    ADD16 sub16(localData1Output, ~localData2Output, 1'b1, subOut, subCout);
    MUL16 mul16(localData1Output, localData2Output, mulOut);
    DIV16 div16(clk, controlSignals[3], localData1Output, localData2Output, quotient, remainder, divFinished);

    
    always_comb
    begin 
        case(operation)
            4'h0: out = constOut;
            4'h1: out = addOut;
            4'h2: out = subOut;
            4'h3: out = mulOut;
            4'h4: out = quotient;

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

    assign enableWrite = ~(operation[3] & operation[2] & operation[1] & operation[0]);
    assign flags = { addCarry, subCarry, 30'b00_0000_0000_0000_0000_0000_0000_0000 };
    assign outputOperation = operation;
    assign controlHold = controlSignals[2];

endmodule