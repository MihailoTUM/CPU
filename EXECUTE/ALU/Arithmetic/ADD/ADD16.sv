

module ADD16(
    input logic [15:0] inData1,
    input logic [15:0] inData2,
    input logic inCarry,

    output logic [15:0] outResult,
    output logic outCarry
);
    logic carry[2:0];

    ADD4 add0(inData1[3:0], inData2[3:0], inCarry, outResult[3:0], carry[0]);
    ADD4 add1(inData1[7:4], inData2[7:4], carry[0], outResult[7:4], carry[1]);
    ADD4 add2(inData1[11:8], inData2[11:8], carry[1], outResult[11:8], carry[2]);
    ADD4 add3(inData1[15:12], inData2[15:12], carry[2], outResult[15:12], outCarry);
endmodule