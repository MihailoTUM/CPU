

module LOAD16(
    input logic [15:0] inBaseAddress,
    input logic [3:0] inOffsetAddress,

    output logic [15:0] outNewAddress
);
    logic [15:0] localExpandedAddress;

    CONST16_4 const_4(inOffsetAddress, localExpandedAddress);
    ADD16 add(inBaseAddress, localExpandedAddress, 1'b0, outNewAddress, );

endmodule