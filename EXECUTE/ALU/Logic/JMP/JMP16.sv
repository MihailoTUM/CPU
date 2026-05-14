

module JMP16(
    input logic [7:0] inData,
    input logic [15:0] inOldAddress,

    output logic [15:0] outNewAddress
);
    logic [15:0] localExpandedAddress;

    CONST16 constFixed(inData, localExpandedAddress);
    ADD16 addFixed(inOldAddress, localExpandedAddress, 1'b0, outNewAddress, );

endmodule