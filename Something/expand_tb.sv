`timescale 1ns/1ns

module expand_tb;
    logic [7:0] in;
    logic sign;
    logic [15:0] expandedInput;

    expand dut(
        .in(in),
        .sign(sign),
        .expandedInput(expandedInput)
    );

    initial begin
        $dumpfile("expand.vcd");
        $dumpvars(0, expand_tb);

        in = 8'hF0; sign = 1; #10; // FFF0
        in = 8'h09; sign = 1; #10; // 0009

        $finish;
    end

endmodule