

module ALUControl(
    input logic [3:0]   inOperation,
    input logic [15:0]  inData1,
    input logic [15:0]  inData2,

    input logic [3:0]   inData1Address,
    input logic [3:0]   inData2Address,

    input logic         inDeactivateExecutePath,
    input logic         inDeactivateMemoryPath,
    input logic [15:0]  inExecuteOutputData,
    input logic [3:0]   inExecuteOutputDataSrc,
    input logic [15:0]  inDataMemoryOutputData,
    input logic [3:0]   inDataMemoryOutputDataSrc,

    output logic [15:0] outData1,
    output logic [15:0] outData2,

    output logic        outWriteToRegisterEnable,
    output logic        outWriteToMemoryEnable
);

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
                4'hF: 
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

    logic isExecute1;
    logic isMemory1;
    logic isExecute2;
    logic isMemory2;

    assign isExecute1 = ~(inData1Address ^ inExecuteOutputDataSrc);
    assign isMemory1 = ~(inData1Address ^ inDataMemoryOutputDataSrc);

    assign isExecute2 = ~(inData2Address ^ inExecuteOutputDataSrc);
    assign isMemory2 = ~(inData2Address ^ inDataMemoryOutputDataSrc);

    assign outData1 = inDeactivateExecutePath ? ;
    assign outData2 = ;
    
endmodule