

module ALUControl(
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    input logic [15:0] inExecuteOutputData,
    input logic [3:0] inExecuteOutputDataSrc,

    input logic [15:0] inDataMemoryOutputData,
    input logic [3:0] inDataMemoryOutputDataSrc,

    output logic [15:0] outData1,
    output logic [15:0] outData2,

    output logic outSignalForDiv,
    output logic outWriteToRegisterEnable,
    output logic outWriteToMemoryEnable
);

    assign outSignalForDiv = (inOperation == 4'h4);

    always_comb
        begin
            case(inOperation)
                4'h8: 
                    begin
                        outWriteToRegisterEnable = 0;
                        outWriteToMemoryEnable = 0;
                    end

                4'h9:
                    begin
                        outWriteToRegisterEnable = 0;
                        outWriteToMemoryEnable = 0;
                    end
                4'hD:
                    begin
                        outWriteToMemoryEnable = 0;
                    end
                4'hE:
                    begin
                        outWriteToRegisterEnable = 0;
                    end

            default: 
                begin
                    outWriteToRegisterEnable = 1;
                    outWriteToMemoryEnable = 1;
                end
            endcase
        end

    
    logic data1FPathExecute;
    logic data1FPathDataMemory;

    logic data2FPathExecute;
    logic data2FPathDataMemory;

    assign data1FPathExecute = ~|(inExecuteOutputDataSrc ^ inData1Address);
    assign data1FPathDataMemory = ~|(inDataMemoryOutputDataSrc ^ inData1Address);

    assign data2FPathExecute = ~|(inExecuteOutputDataSrc ^ inData2Address);
    assign data2FPathDataMemory = ~|(inDataMemoryOutputDataSrc ^ inData2Address);

    assign outData1 = data1FPathExecute ? inExecuteOutputData: data1FPathDataMemory ? inDataMemoryOutputData: inData1;
    assign outData2 = data2FPathExecute ? inExecuteOutputData: data2FPathDataMemory ? inDataMemoryOutputData: inData2;

endmodule