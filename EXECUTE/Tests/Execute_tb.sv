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

    initial clk = 1;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);


        // instruction CONST 1
        opcode = 4'h0; dst = 4'h0; iOperand = 8'h04; 
        // waiting for one cycle
        #4;

        // instruction CONST 2
        opcode = 4'h0; dst = 4'h1; iOperand = 8'h05;
        // waiting for one cycle
        #4;

        // instruction ADD
        opcode = 4'h1; dst = 4'h2; srcA = 16'h000A; srcB = 16'h0001;
        //waiting for one cycle
        #4;

        $finish;
    end
endmodule