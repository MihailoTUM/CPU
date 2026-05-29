

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
    output logic [15:0] outDataResult,
    output logic [15:0] outMemoryAddress,

    // output logic outAddressToRETSignal
    // output logic [15:0] outAddressToRET,
);
    logic [15:0] constFixedOutput;
    logic [15:0] addFixedOutput;
    logic addFixedCarryOut;
    logic [15:0] subFixedOutput;
    logic subFixedCarryOut;
    logic [31:0] mulFixedOutput;
    logic [15:0] divFixedOutput;
    logic [15:0] divFixedRemainder;
    logic [15:0] addIFixedOutput;

    logic [15:0] localJMPAddress;
    logic [15:0] localBranchAddress;
    logic localBranchSuccess;

    logic [15:0] outLoadAddress;

    logic [15:0] outStoreAddress;
    logic [15:0] outStoreData;

    // logic [15:0] localAddressToGO;
    // logic [15:0] localAddressToRET;

    // logic [15:0] localRETAddress;

    CONST16 constFixed(inImmediate, constFixedOutput);
    ADD16 addFixed(inData1, inData2, 1'b0, addFixedOutput, addFixedCarryOut);
    ADD16 subFixed(inData1, ~inData2, 1'b1, subFixedOutput, subFixedCarryOut);
    MUL16 mulFixed(inData1, inData2, mulFixedOutput);
    DIV16 divFixed(clk, hold, inData1, inData2, divFixedOutput, divFixedRemainder, divFinished);
    ADDI16 addIFixed(inData1, inImmediate, addIFixedOutput);

    JMP16 jumpFixed(inInstructionAddress, inImmediate, localJMPAddress);
    BZ16 bzFixed(inInstructionAddress, inImmediate, inData1, localBranchAddress, localBranchSuccess);

    LOAD16 load(inData1, inImmediate[3:0], outLoadAddress);
    STORE16 store(inData2, inImmediate[3:0], inData1, outStoreAddress, outStoreData);

    // CALL call(inImmediate, inInstructionAddress, localAddressToGO, localAddressToRET);
    // RET ret(inData1, localRETAddress);

    // assign outAddressTORET = localAddressToRET;



    always_comb 
        begin   
            case(inOperation)
                4'h0: outDataResult = constFixedOutput;
                4'h1: outDataResult = addFixedOutput;
                4'h2: outDataResult = subFixedOutput;
                4'h3: outDataResult = mulFixedOutput[15:0];
                4'h4: outDataResult = divFixedOutput;

                4'hA: outDataResult = addIFixedOutput;

                // 4'hB: outDataResult = localAddressToGO;
                // 4'hC: outDataResult = localRETAddress;

                4'hE: outDataResult = outStoreData;
                4'hF: outDataResult = 16'hXXXX;

                default: outDataResult = 16'hABCD;
            endcase
        end

    always_comb 
        begin
            case(inOperation)
                4'h8: outMemoryAddress = localJMPAddress;
                4'h9: outMemoryAddress = localBranchAddress;

                4'hD: outMemoryAddress = outLoadAddress;
                4'hE: outMemoryAddress = outStoreAddress;

            endcase
        end


    // assign outAddressToRETSignal = inOperation[3] & ~(inOperation[2]) & inOperation[1] & inOperation[0];

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

endmodule