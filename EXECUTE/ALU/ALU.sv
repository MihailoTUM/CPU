

module ALU(
    input logic [3:0] operation,
    input logic [15:0] data1,
    input logic [15:0] data2,
    input logic [7:0] immediateOperand,
    output logic [15:0] result,
    output logic enableWrite
);
    // const function
    logic [15:0] constOut;
    // add
    logic [15:0] addOut;
    logic addCout;
    // sub
    logic [15:0] subOut;
    logic subCout;
    // and
    logic [15:0] andOut;
    // or
    logic [15:0] orOut;
    // xor
    logic [15:0] xorOut;


    // arithmetic
    CONST16 const16(immediateOperand, constOut);
    ADD16 add16(data1, data2, 1'b0, addOut, addCout);
    ADD16 sub16(data1, ~data2, 1'b1, subOut, subCout);
    // MUL
    // DIV

    // logic
    AND16 and16(data1, data2, andOut);
    OR16 or16(data1, data2, orOut);
    XOR16 xor16(data1, data2, xorOut);


    // functional stalls NOPs


    always_comb
    begin 
        case(operation)
            // arithmetic
            4'h0: result = constOut;
            4'h1: result = addOut;
            4'h2: result = subOut;

            // logic
            4'h5: result = andOut;
            4'h6: result = orOut;
            4'h7: result = xorOut;

            // (stall) NOP
            4'hF: result = 16'hXXXX;
            default: result = 16'hXXXX;
        endcase
    end

    assign enableWrite = ~(operation[3] & operation[2] & operation[1] & operation[0]);

endmodule