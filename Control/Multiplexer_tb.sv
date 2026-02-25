`timescale 1ns/1ns

module Multiplexer_tb;
    logic [15:0] d0;
    logic [15:0] d1;
    logic control;
    logic [15:0] out;

    Multiplexer_m dut(
        .d0(d0),
        .d1(d1),
        .control(control),
        .out(out)
    );

    initial begin
        $dumpfile("Multiplexer.vcd");
        $dumpvars(0, Multiplexer_tb);

        d0 = 16'h0001; d1 = 16'h0FFF; control = 0; #10;
        d0 = 16'h0F00; d1 = 16'hABCD; control = 1; #10;

    end;
endmodule;