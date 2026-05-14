

module ALUFlag(
    input logic [3:0] inOperation,

    output logic outEnableWrite,
    output logic [3:0] outOperation,
    output logic JMPSignalToControl
);

    always_comb
    begin
        case(operation)
            4'h8: enableWrite = 0;
            4'hF: enableWrite = 0;

            default: enableWrite = 1;
        endcase
    end

    assign outputOperation = operation;

    always_comb
    begin
        case(operation)
        4'h8: JMPSignalToControl = 1;

        default: JMPSignalToControl = 0;
        endcase
    end

endmodule