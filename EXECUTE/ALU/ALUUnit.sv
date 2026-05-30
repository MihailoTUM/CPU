

module ALUUnit(
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,
    
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    output logic [15:0] outDataResult,
    output logic [15:0] outMemoryAddress,
    output logic [15:0] outFlagRegister,

    output logic outJMPSignal,
    output logic outWriteReturnAddressToRegisterSignal
    );

    logic [15:0] constOut;
    CONST16 const16(inImmediate, constOut);

    logic [15:0] addOut;
    logic addCarry;
    ADD16 add16(inData1, inData2, 1'b0, addOut, addCarry);

    logic [15:0] subOut;
    SUB16 sub16(inData1, inData1, subOut);

    logic [15:0] mulOut;
    MUL16 mul16(inData1, inData2, , mulOut);

    logic [15:0] addIOut;
    logic addICarry;
    ADDI16 addI16(inData1, inImmediate, addIOut, addICarry);

    logic [15:0] jmpAddress;
    JMP16 jmp16(inInstructionAddress, inImmediate, jmpAddress);

    logic [15:0] branchAddress;
    logic branchSuccess;
    BZ16 bz16(inData1, inImmediate, branchAddress, branchSuccess);

    logic [15:0] loadAddress;
    LOAD16 load16(inData1, inImmediate[3:0], loadAddress);

    logic [15:0] storeAddress;
    logic [15:0] storeData;
    STORE16 store16(inData2, inImmediate[3:0], inData1, storeAddress, storeData);

    logic [15:0] callAdress;
    logic [15:0] returnAdress;
    CALL call(inInstructionAddress, inImmediate, callAdress, returnAdress);

    logic [15:0] returnAdress2;
    RET ret(inData1, returnAdress2);

    always_comb
        begin
            case(inOperation)
                4'h0: outDataResult = constOut;
                4'h1: outDataResult = addOut;
                4'h2: outDataResult = subOut;
                4'h3: outDataResult = mulOut;

                4'hA: outDataResult = addIOut;
                4'hB: outDataResult = returnAdress;

                4'hE: outDataResult = storeData;

                default: outDataResult = 16'hXXXX;
            endcase
        end

    always_comb
        begin
            case(inOperation)
                4'h8: outMemoryAddress = jmpAddress;
                4'h9: outMemoryAddress = branchAddress;

                4'hB: outMemoryAddress = callAdress;
                4'hC: outMemoryAddress = returnAdress2;
                4'hD: outMemoryAddress = loadAddress;
                4'hE: outMemoryAddress = storeAddress;

                default: outMemoryAddress = 16'hXXXX;
            endcase
        end

    always_comb
        begin
            case(inOperation)
                4'h8: outJMPSignal = 1;
                4'h9:   if(branchSuccess) outJMPSignal = 1;
                        else outJMPSignal = 0;
                
                4'hB: outWriteReturnAddressToRegisterSignal = 1;
                4'hC: outJMPSignal = 1;

                default:
                    begin
                         outJMPSignal = 0;
                         outWriteReturnAddressToRegisterSignal = 0;
                    end
            endcase
        end

endmodule