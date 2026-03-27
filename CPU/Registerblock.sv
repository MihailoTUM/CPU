
// 3 address machine
// 2 for source
// 1 for destination    

module Registerblock(
    input logic clk,
    input logic reset,
    input logic writeEnable,
    input logic [3:0] destination,
    input logic [3:0] source1,
    input logic [3:0] source2, 
    input logic [15:0] dataInput,
    output logic [15:0] rOutput1,
    output logic [15:0] rOutput2
);
    // 16 Registers
    logic [15:0] r0;
    logic [15:0] r1;
    logic [15:0] r2;
    logic [15:0] r3;
    logic [15:0] r4;
    logic [15:0] r5;
    logic [15:0] r6;
    logic [15:0] r7;
    logic [15:0] r8;
    logic [15:0] r9;
    logic [15:0] r10;
    logic [15:0] r11;
    logic [15:0] r12;
    logic [15:0] r13;
    logic [15:0] r14;
    logic [15:0] r15;

    always_ff @(posedge clk)
    begin 
        if(reset) 
        begin
            r0 <= 16'h0000;
            r1 <= 16'h0000;
            r2 <= 16'h0000;
            r3 <= 16'h0000;
            r4 <= 16'h0000;
            r5 <= 16'h0000;
            r6 <= 16'h0000;
            r7 <= 16'h0000;
            r8 <= 16'h0000;
            r9 <= 16'h0000;
            r10 <= 16'h0000;
            r11 <= 16'h0000;
            r12 <= 16'h0000;
            r13 <= 16'h0000;
            r14 <= 16'h0000;
            r15 <= 16'h0000;
        end
        else if(we)
        begin
            case(dst)
            4'b0000: r0 <= dataInput;
            4'b0001: r1 <= dataInput;
            4'b0010: r2 <= dataIn;
            4'b0011: r3 <= dataIn;
            4'b0100: r4 <= dataIn;
            4'b0101: r5 <= dataIn;
            4'b0110: r6 <= dataIn;
            4'b0111: r7 <= dataIn;
            4'b1000: r8 <= dataIn;
            4'b1001: r9 <= dataIn;
            4'b1010: r10 <= dataIn;
            4'b1011: r11 <= dataIn;
            4'b1100: r12 <= dataIn;
            4'b1101: r13 <= dataIn;
            4'b1110: r14 <= dataIn;
            4'b1111: r15 <= dataIn;
            default: r0 <= dataIn;
            endcase
        end
    end

    always_comb 
    begin
        case(source1)
            4'b0000: out1 = r0;
            4'b0001: out1 = r1;
            4'b0010: out1 = r2;
            4'b0011: out1 = r3;
            4'b0100: out1 = r4;
            4'b0101: out1 = r5;
            4'b0110: out1 = r6;
            4'b0111: out1 = r7;
            4'b1000: out1 = r8;
            4'b1001: out1 = r9;
            4'b1010: out1 = r10;
            4'b1011: out1 = r11;
            4'b1100: out1 = r12;
            4'b1101: out1 = r13;
            4'b1110: out1 = r14;
            4'b1111: out1 = r15;
            default: out1 = 16'h0000;
        endcase

        case(source2)
            4'b0000: out2 = r0;
            4'b0001: out2 = r1;
            4'b0010: out2 = r2;
            4'b0011: out2 = r3;
            4'b0100: out2 = r4;
            4'b0101: out2 = r5;
            4'b0110: out2 = r6;
            4'b0111: out2 = r7;
            4'b1000: out2 = r8;
            4'b1001: out2 = r9;
            4'b1010: out2 = r10;
            4'b1011: out2 = r11;
            4'b1100: out2 = r12;
            4'b1101: out2 = r13;
            4'b1110: out2 = r14;
            4'b1111: out2 = r15;
            default: out2 = 16'h0000;
        endcase
    end

endmodule