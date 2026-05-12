

module ALUExecute(
    // control inputs
    input logic clk,
    input logic hold,

    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,
    input logic [7:0] inImmediate,

    output logic [15:0] ALUOutput,
    output logic [15:0] flags,
    output logic divFinished
);
    logic [15:0] constFixedOutput;
    logic [15:0] addFixedOutput;
    logic addFixedCarryOut;
    logic [15:0] subFixedOutput;
    logic subFixedCarryOut;
    logic [31:0] mulFixedOutput;

    // combinational arithmetic-logic operations
    CONST16 constfixed(inImmediate, constOutput);
    ADD16 addfixed(inData1, inData2, 1'b0, addFixedOutput, addFixedCarryOut);
    ADD16 subfixed(inData1, ~inData2, 1'b1, subFixedOuput, subFixedCarryOut);
    MUL16 mulfixed(inData1, inData2, mulFixedOutput);

    logic [15:0] divFixedOutput;
    logic [15:0] divFixedRemainder;

    // sequential arithmetic-logic operations
    DIV divFixed(clk, hold, inData1, inData2, divFixedOutput, divFixedRemainder, divFinished);


    always_comb 
    begin   
        case(inOperation)
            4'h0: ALUOutput = constFixedOutput;
            4'h1: ALUOutput = addFixedOutput;
            4'h2: ALUOutput = subFixedOutput;
            4'h3: ALUOutput = mulFixedOutput;
            4'h4: ALUOutput = divFixedOutput;

            4'h8: ALUOutput = constFixedOutput;

            4'hF: ALUOutput = 16'hXXXX;

            default: ALUOutput = 16'hABCD;
        endcase
    end

    assign flags = { addFixedCarryOut, subFixedCarryOut, 14'b00_0000_0000_0000 };

endmodule