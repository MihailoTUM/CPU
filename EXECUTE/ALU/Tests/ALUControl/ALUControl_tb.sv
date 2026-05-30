`timescale 1ns/1ns

module ALUControl_tb();
    logic clk;
    logic [3:0] operation;
    logic divFinished;
    logic [3:0] controlSignals;

    ALUControl dut(
        .clk(clk),
        .operation(operation),
        .divFinished(divFinished),
        .controlSignals(controlSignals)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("ALUControl.vcd");
        $dumpvars(0, ALUControl_tb);

        #4;
        operation = 4'h0; 

        #4;
        operation = 4'h4;

        #20;
        $finish;
    end
endmodule