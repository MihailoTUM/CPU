

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

    // control outputs
    output logic divFinished,
    output logic outEnableWrite,
    output logic JMPSignalToControl,

    // data outputs
    output logic [15:0] ALUOutput,
    output logic [3:0] outOperation,
    output logic [15:0] outAddressToRET,
    output logic outAddressToRETSignal
);
    logic [15:0] constFixedOutput;
    logic [15:0] addFixedOutput;
    logic addFixedCarryOut;
    logic [15:0] subFixedOutput;
    logic subFixedCarryOut;
    logic [31:0] mulFixedOutput;
    logic [15:0] localNewAddress;

    logic [15:0] localBranchNewAddress;
    logic branchSuccess;

    logic [15:0] addIFixedOutput;
    logic [15:0] loadAddressOutput;
    logic [15:0] storeAddressOutput;

    logic [15:0] localAddressToGO;
    logic [15:0] localAddressToRET;

    logic [15:0] localRETAddress;

    // combinational arithmetic-logic operations
    CONST16 constFixed(inImmediate, constFixedOutput);
    ADD16 addFixed(inData1, inData2, 1'b0, addFixedOutput, addFixedCarryOut);
    ADD16 subFixed(inData1, ~inData2, 1'b1, subFixedOutput, subFixedCarryOut);
    MUL16 mulFixed(inData1, inData2, mulFixedOutput);

    ADDI16 addIFixed(inData1, inImmediate, addIFixedOutput);

    // logic
    JMP16 jumpFixed(inImmediate, inInstructionAddress, localNewAddress);
    BZ16 bzFixed(inImmediate, inInstructionAddress, localBranchNewAddress, branchSuccess);

    // memory 
    LOAD16 load(inData1, inImmediate[3:0], loadAddressOutput);
    STORE16 store(inData1, inImmediate[3:0], storeAddressOutput);

    // function calls
    // CALL call(inData1, inImmediate[3:0], localAddressToGO, localAddressToRET);
    CALL call(inImmediate, inInstructionAddress, localAddressToGO, localAddressToRET);
    RET ret(inData1, localRETAddress);

    assign outAddressTORET = localAddressToRET;

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
            4'h9: ALUOutput = localBranchNewAddress;
            4'hA: ALUOutput = addIFixedOutput;

            4'hB: ALUOutput = localAddressToGO;
            4'hC: ALUOutput = localRETAddress;
            4'hF: ALUOutput = 16'hXXXX;

            default: ALUOutput = 16'hABCD;
        endcase
    end

    assign outAddressToRETSignal = inOperation[3] & ~(inOperation[2]) & inOperation[1] & inOperation[0];

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
            4'h9: 
                begin
                    if(branchSuccess) JMPSignalToControl = 1;
                    else JMPSignalToControl = 0;
                end
            default: JMPSignalToControl = 0;
        endcase
    end

    assign outOperation = inOperation;

endmodule