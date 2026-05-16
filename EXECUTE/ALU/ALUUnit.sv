

module ALUUnit(
    // control inputs
    input logic clk,
    input logic hold,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inStackPointerAddress,

    // control outputs
    output logic divFinished,
    output logic outEnableWrite,
    output logic JMPSignalToControl,

    // data outputs
    output logic [15:0] ALUOutput,
    output logic [3:0] outOperation
);
    logic [15:0] constFixedOutput;
    logic [15:0] addFixedOutput;
    logic addFixedCarryOut;
    logic [15:0] subFixedOutput;
    logic subFixedCarryOut;
    logic [31:0] mulFixedOutput;
    logic [15:0] localNewAddress;

    // combinational arithmetic-logic operations
    CONST16 constFixed(inImmediate, constFixedOutput);
    ADD16 addFixed(inData1, inData2, 1'b0, addFixedOutput, addFixedCarryOut);
    ADD16 subFixed(inData1, ~inData2, 1'b1, subFixedOutput, subFixedCarryOut);
    MUL16 mulFixed(inData1, inData2, mulFixedOutput);
    JMP16 jumpfixed(inImmediate, inInstructionAddress, localNewAddress);

    logic [15:0] divFixedOutput;
    logic [15:0] divFixedRemainder;

    // sequential arithmetic-logic operations
    DIV16 divFixed(clk, hold, inData1, inData2, divFixedOutput, divFixedRemainder, divFinished);


    always_comb 
    begin   
        case(inOperation)
            4'h0: ALUOutput = constFixedOutput;
            4'h1: ALUOutput = addFixedOutput;
            4'h2: ALUOutput = subFixedOutput;
            4'h3: ALUOutput = mulFixedOutput;
            4'h4: ALUOutput = divFixedOutput;

            4'h8: ALUOutput = localNewAddress;


            4'hF: ALUOutput = 16'hXXXX;

            default: ALUOutput = 16'hABCD;
        endcase
    end

    always_comb
    begin
        case(inOperation)
            4'h8: outEnableWrite = 0;
            4'hF: outEnableWrite = 0;

            default: outEnableWrite = 1;
        endcase
    end

    always_comb
    begin
        case(inOperation)
            4'h8: JMPSignalToControl = 1;

            default: JMPSignalToControl = 0;
        endcase
    end

    assign outOperation = inOperation;

endmodule