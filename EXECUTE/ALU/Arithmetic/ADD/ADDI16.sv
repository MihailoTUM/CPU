

module ADDI16(
    input logic [15:0] inData,
    input logic [7:0] offset,

    output logic [15:0] outData,
    output logic outCarry
);
    logic [15:0] localExtendedInput;

    CONST16 const16(offset, localExtendedInput);
    ADD16 add16(inData, localExtendedInput, 1'b0, outData, outCarry);

endmodule