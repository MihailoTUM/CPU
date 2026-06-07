

module STORE16(
    input logic [15:0] inBaseAddress,
    input logic [3:0] inOffsetAddress,
    input logic [15:0] inData,

    output logic [15:0] outNewAddress,
    output logic [15:0] outData
);
    logic [15:0] localExpandedAddress;

    CONST16S_4 const_4(inOffsetAddress, localExpandedAddress);
    ADD16 add(inBaseAddress, localExpandedAddress, 1'b0, outNewAddress, );

    assign outData = inData;

endmodule