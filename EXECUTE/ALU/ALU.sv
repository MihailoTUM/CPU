// include forward path

module ALU(
    // control inputs
    input logic clk,
    // data inputs
    input logic [3:0] operation,
    input logic [3:0] beforeAddress,
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
    output logic [31:0] flags,
    output logic [15:0] JMPAddressToControl,
    output logic JMPSignalToControl
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
        .beforeAddress(beforeAddress),
        .data1Input(d1),
        .data2Input(d2),
        
        .forwardPathInput(forwardPathInput),
        .forwardPathInputSrc(forwardPathInputSrc),
        .forwardPathSrc1Address(forwardSrc1Address),
        .forwardPathSrc2Address(forwardSrc2Address),
        
        .controlSignals(controlSignals),
        .data1Output(localData1Output),
        .data2Output(localData2Output)
    );

    ALUExecute aluExecute(
        .clk(clk),
        .hold(controlSignals[3]),
    );


    logic [15:0] constOut;

    logic [15:0] addOut;
    logic addCarry;

    logic [15:0] subOut;
    logic subCarry;

    logic [31:0] mulOut;

    CONST16 const16(immediate, constOut);
    ADD16 add16(localData1Output, localData2Output, 1'b0, addOut, addCout);
    ADD16 sub16(localData1Output, ~localData2Output, 1'b1, subOut, subCout);
    MUL16 mul16(localData1Output, localData2Output, mulOut);


    DIV16 div16(clk, controlSignals[3], localData1Output, localData2Output, quotient, remainder, divFinished);

    // combinational arithmetic-logic operations
    always_comb
    begin 
        case(operation)
            4'h0: out = constOut;
            4'h1: out = addOut;
            4'h2: out = subOut;
            4'h3: out = mulOut;
            4'h4: out = quotient;

            4'h8: out = constOut;

            4'hF: out = 16'hXXXX;
            default: out = 16'hABCD;
        endcase
    end



    Flag flag(
        .operation(operation),
        
        .enableWrite(enableWrite),
        .outputOperation(outputOperation),
        .JMPSignalToControl(JMPSignalToControl)
    );

    assign controlHold = controlSignals[2];

endmodule