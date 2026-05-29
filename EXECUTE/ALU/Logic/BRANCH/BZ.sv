

module BZ16(
    input logic [15:0] inInstructionAddress,
    input logic [7:0] inOffset,
    input logic [15:0] inData,

    output logic [15:0] outInstructionAddress,
    output logic outBranchSuccess
);
    logic [15:0] localAddress;

    CONST16 constFixed(inOffset, localAddress);
    ADD16 addFixed(inInstructionAddress, localAddress, 1'b0, outInstructionAddress, );

    assign outBranchSuccess = ~|(inData);

endmodule