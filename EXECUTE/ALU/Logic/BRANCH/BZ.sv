

module BZ16(
    input logic [15:0] inData,
    input logic [7:0] inOffset,

    output logic [15:0] outInstructionAddress,
    output logic outBranchSuccess
);
    CONST16U constFixed(inOffset, outInstructionAddress);

    assign outBranchSuccess = ~|(inData);
endmodule