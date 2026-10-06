

module JMP16(
    input logic [15:0] inInstructionAddress,
    input logic [7:0] inOffset,

    output logic [15:0] outInstructionAddress
);
    logic [15:0] localAddress;

    CONST16S constFixed(inOffset, localAddress);
    ADD16 addFixed(inInstructionAddress, localAddress, 1'b0, outInstructionAddress, );
endmodule