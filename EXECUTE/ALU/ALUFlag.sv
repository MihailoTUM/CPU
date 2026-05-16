

module ALUFlag(
    input logic [3:0] inOperation,

    output logic outEnableWrite,
    output logic [3:0] outOperation,
    output logic JMPSignalToControl
);

    always_comb
    begin
        case(inOperation)
            4'h8: outEnableWrite = 0;
            4'hF: outEnableWrite = 0;

            default: outEnableWrite = 1;
        endcase
    end

    assign outputOperation = inOperation;

    always_comb
    begin
        case(inOperation)
        4'h8: JMPSignalToControl = 1;

        default: JMPSignalToControl = 0;
        endcase
    end

endmodule