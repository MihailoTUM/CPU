`timescale 1ns/1ns

module ALUControl_tb();
    logic [3:0] inOperation;
    logic [15:0] inData1;
    logic [15:0] inData2;

    logic [3:0] inData1Address;
    logic [3:0] inData2Address;

    logic inDeactivateExecutePath;
    logic inDeactivateMemoryPath;
    logic [15:0] inExecuteOutputData;
    logic [3:0] inExecuteOutputDataSrc;
    logic [15:0] inDataMemoryOutputData;
    logic [3:0] inDataMemoryOutputDataSrc;

    logic [15:0] outData1;
    logic [15:0] outData2;

    logic outWriteToRegisterEnable;
    logic outWriteToMemoryEnable;

    ALUControl dut(
        .inOperation(inOperation),
        .inData1(inData1),
        .inData2(inData2),

        .inData1Address(inData1Address),
        .inData2Address(inData2Address),

        .inDeactivateExecutePath(inDeactivateExecutePath),
        .inDeactivateMemoryPath(inDeactivateMemoryPath),
        .inExecuteOutputData(inExecuteOutputData),
        .inExecuteOutputDataSrc(inExecuteOutputDataSrc),
        .inDataMemoryOutputData(inDataMemoryOutputData),
        .inDataMemoryOutputDataSrc(inDataMemoryOutputDataSrc),

        .outData1(outData1),
        .outData2(outData2),

        .outWriteToRegisterEnable(outWriteToRegisterEnable),
        .outWriteToMemoryEnable(outWriteToMemoryEnable)
    );

    initial
    begin
        $dumpfile("ALUControl.vcd");
        $dumpvars(0, ALUControl_tb);    

        inData1 = 16'h0001; inData2 = 16'h0002; inData1Address = 4'h0; inData2Address = 4'h1; inExecuteOutputData = 16'hABCD; inExecuteOutputDataSrc = 4'h0; inDataMemoryOutputData = 16'h1234; inDataMemoryOutputDataSrc = 4'h1; inDeactivateExecutePath = 0; inDeactivateMemoryPath = 0;
        #4;
        assert(outData1 == 16'hABCD) else $error("Error a");
        assert(outData2 == 16'h1234) else $error("Error b");
        #4;

        inData1 = 16'h0001; inData2 = 16'h0002; inData1Address = 4'h0; inData2Address = 4'h1; inExecuteOutputData = 16'hABCD; inExecuteOutputDataSrc = 4'h0; inDataMemoryOutputData = 16'h1234; inDataMemoryOutputDataSrc = 4'h1; inDeactivateExecutePath = 1; inDeactivateMemoryPath = 0;
        #4;
        assert(outData1 == 16'h0001) else $error("Error c");
        assert(outData2 == 16'h1234) else $error("Error d");
        #4;

        inData1 = 16'h0001; inData2 = 16'h0002; inData1Address = 4'h0; inData2Address = 4'h1; inExecuteOutputData = 16'hABCD; inExecuteOutputDataSrc = 4'h0; inDataMemoryOutputData = 16'h1234; inDataMemoryOutputDataSrc = 4'h1; inDeactivateExecutePath = 0; inDeactivateMemoryPath = 1;
        #4;
        assert(outData1 == 16'hABCD) else $error("Error e");
        assert(outData2 == 16'h0002) else $error("Error f");
        #4;

        inData1 = 16'h0001; inData2 = 16'h0002; inData1Address = 4'h0; inData2Address = 4'h1; inExecuteOutputData = 16'hABCD; inExecuteOutputDataSrc = 4'h0; inDataMemoryOutputData = 16'h1234; inDataMemoryOutputDataSrc = 4'h1; inDeactivateExecutePath = 1; inDeactivateMemoryPath = 1;
        #4;
        assert(outData1 == 16'h0001) else $error("Error g");
        assert(outData2 == 16'h0002) else $error("Error h");
        #4;

        inData1 = 16'h0001; inData2 = 16'h0002; inData1Address = 4'h0; inData2Address = 4'h1; inExecuteOutputData = 16'hABCD; inExecuteOutputDataSrc = 4'h2; inDataMemoryOutputData = 16'h1234; inDataMemoryOutputDataSrc = 4'h3; inDeactivateExecutePath = 0; inDeactivateMemoryPath = 0;
        #4;
        assert(outData1 == 16'h0001) else $error("Error i");
        assert(outData2 == 16'h0002) else $error("Error j");
        #4;

        $finish;
    end
endmodule