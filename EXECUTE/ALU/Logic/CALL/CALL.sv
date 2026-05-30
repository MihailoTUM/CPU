
// special write to register operation;
// output directly goes to Registers

module CALL(
    input logic [15:0] inInstructionAddress,
    input logic [7:0] inNewAddress,

    output logic [15:0] outJMPAddress,
    output logic [15:0] outReturnAddress
);

    logic [15:0] localAddress;

    CONST16U constU(inNewAddress, localAddress);
    ADD16 add(inInstructionAddress, 16'h0002, 1'b0, outReturnAddress, );

    assign outJMPAddress = localAddress;

endmodule