
module DIV16(
    input logic clk,
    input logic reset,
    input logic [15:0] dividend,
    input logic [15:0] divisor,
    output logic [15:0] quotient,
    output logic [15:0] remainder,
    output logic finished
);
    logic [9:0] localSignals;
    logic [15:0] subResult;
    logic [15:0] subInput;
    logic lastRound;

    Control control(
        .clk(clk),
        .reset(reset),
        .MSB(subResult[15]),
        // outputs
        .signals(localSignals),
        .finished(finished)
    );

    ADD16 sub(
        .a(subInput),
        .b(~divisor),
        .carryIn(1'b1),
        // outputs
        .result(subResult),
        .carryOut()
    );

    DivRegister divReg(
        .clk(localSignals[9]),
        .reset(localSignals[8]),
        .writeLowData(dividend),
        .writeHighData(subResult),
        .enableWriteHigh(localSignals[7]),
        .shift(localSignals[6]),
        // outputs
        .q(subInput)
    );

    QuoRegister quoReg(
        .clk(localSignals[5]),
        .reset(localSignals[4]),
        .digit(~subResult[15]),
        .selection(localSignals[3:0]),
        // outputs
        .q(quotient)
    );

    assign remainder = subInput;

endmodule