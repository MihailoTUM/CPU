

module SUB16(
    input logic [15:0] inData1,
    input logic [15:0] inData2,  
    
    output logic [15:0] outResult
);

    ADD16 sub16(inData1, ~inData2, 1'b1, outResult,  );

endmodule

