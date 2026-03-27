

module ALU(
    input logic [3:0] instruction
    input logic [15:0] inputALU1,
    input logic [15:0] inputALU2,
    output logic [15:0] outputALU
    output logic [3:0] flag
);
    // arithmetic logic operations
    logic [15:0] outputALU0;
    logic [15:0] outputALU1;
    logic [15:0] outputALU2;
    logic [15:0] outputALU3;
    logic [15:0] outputALU4;
    logic [15:0] outputALU5;
    logic [15:0] outputALU6;
    logic [15:0] outputALU7;
    logic [15:0] outputALU8;
    logic [15:0] outputALU0;
    logic [15:0] outputALU10;
    logic [15:0] outputALU11;
    logic [15:0] outputALU12;
    logic [15:0] outputALU13;
    logic [15:0] outputALU14;
    logic [15:0] outputALU15;

    logic cout;

    CONST16 const16(8'h01, outputALU0);

    // arithmetic
    ADD16 add16(inputALU1, inputALU2, 1'b0, outputALU1, cout);
    ADD16 sub16(inputALU1, ~inputALU2, 1'b1, outputALU2, cout);

    // logic
    AND16 and16(inputALU1, inputALU2, outputALU3);
    OR16 or16(inputALU1, inputALU2, outputALU4);

    SRU sru16(inputALU1, inputALU2[3:0], outputALU5);
    SLU slu16(inputALU1, inputALU2[3:0], outputALU6);

    /*
    0x0000 -> CONST
    0x1000 -> ADD
    0x2000 -> SUB
    0x3000 -> AND
    0x4000 -> OR
    0x5000 -> SRU
    0x6000 -> SRU 

    */

    always_comb
    begin
        case(instruction)
            4'h0: outputALU = outputALU0;
            4'h1: outputALU = outputALU1;
            4'h2: outputALU = outputALU2;
            4'h3: outputALU = outputALU3;
            4'h4: outputALU = outputALU4;
            4'h5: outputALU = outputALU5;
            4'h6: outputALU = outputALU6;

        endcase
    end


    // // flag
    // assign flag[3] = out[15]; // Negative
    // assign flag[2] = &(~out); // Zero
    // assign flag[1] = opcode[0] ? cout[0] : cout[1]; // Carry
    // assign flag[0] = (a[15] & b[15] & ~out[15]) | (~a[15] & ~b[15] & out[15]); // Overflow

    assign flag = 4'h0;

endmodule