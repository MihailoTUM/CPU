
// special write to register operation;
// output directly goes to Registers

module CALL(
    input logic [7:0] inNewAddress,
    input logic [15:0] inInstructionAddress,

    output logic [15:0] outAddressToGO,
    output logic [15:0] outAddressToRET
);
    logic [15:0] localExpanded;

    CONST16 const16(inNewAddress, localExpanded);
    ADD16 add_1(inInstructionAddress, 16'h0002, 1'b0, outAddressToRET, );

    assign outAddressToGO = localExpanded;

endmodule