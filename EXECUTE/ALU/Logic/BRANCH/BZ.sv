

module BZ16(
    input logic [7:0] inData,
    input logic [15:0] inOldAddress,
    input logic [15:0] inRegisterData,

    output logic [15:0] outNewAddress,
    output logic branchSuccess
);
    logic [15:0] localExpandedAddress;

    CONST16 constFixed(inData, localExpandedAddress);
    ADD16 addFixed(inOldAddress, localExpandedAddress, 1'b0, outNewAddress, );

    assign branchSuccess = ~|(inRegisterData);

endmodule