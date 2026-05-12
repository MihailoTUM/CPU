

module Flag(
    input logic [3:0] operation,

    output logic [31:0] flags,
    output logic enableWrite,
    output logic [3:0] outputOperation,
    output logic JMPSignalToControl
);

    // NOP
    assign enableWrite ~(&operation);
    assign outputOperation = operation;

    assign JMPSignalToControl = operation[3] & (~operation[2]) & (~operation[1]) & (~operation[0]);

endmodule