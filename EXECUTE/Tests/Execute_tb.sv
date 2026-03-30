`timescale 1ns/1ns

module Execute_tb();
    // signals
    logic clk;
    logic [3:0] opcode;
    logic [3:0] dst;
    logic [15:0] srcA;
    logic [15:0] srcB;
    logic [7:0] iOperand;
    logic [15:0] data;
    logic [3:0] writeBackDst;

    Execute dut(
        .clk(clk),
        .opcode(opcode),
        .dst(dst),
        .srcA(srcA),
        .srcB(srcB),
        .iOperand(iOperand),
        .data(data),
        .writeBackDst(writeBackDst)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        opcode = 4'h0; dst = 4'h0; iOperand = 8'h01; 

        #100;

        $finish;
    end
endmodule