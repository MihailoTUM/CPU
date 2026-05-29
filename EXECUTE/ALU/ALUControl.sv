

module ALUControl(
    // control inputs
    input logic clk,
    input logic divFinished,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    // forward path
    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [3:0] controlSignals,
    output logic [15:0] outData1,
    output logic [15:0] outData2
);  
    logic multiCycle;

    logic data1FPathExecute;
    logic data1FPathDataMemory;

    logic data2FPathExecute;
    logic data2FPathDataMemory;

    assign data1FPathExecute = ~|(forwardPathInputExecuteSrc ^ inData1Address);
    assign data1FPathDataMemory = ~|(forwardPathInputDataMemorySrc ^ inData1Address);

    assign data2FPathExecute = ~|(forwardPathInputExecuteSrc ^ inData2Address);
    assign data2FPathDataMemory = ~|(forwardPathInputDataMemorySrc ^ inData2Address);

    assign outData1 = data1FPathExecute ? forwardPathInputExecute: data1FPathDataMemory ? forwardPathInputDataMemory: inData1;
    assign outData2 = data2FPathExecute ? forwardPathInputExecute: data2FPathDataMemory ? forwardPathInputDataMemory: inData2;


    always_comb
    begin 
        case(inOperation)
            4'h4: multiCycle = 1;

            default: multiCycle = 0;
        endcase
    end

    typedef enum logic [1:0] { reset1, reset2, loop, finished } statetype;
    statetype state, nextState;

    always_comb 
    begin 
        case(state)
        finished:   if(multiCycle) nextState = reset1;
                    else nextState = finished;
        reset1:     nextState = reset2;
        reset2:     nextState = loop;
        loop:       if(divFinished) nextState = finished;
                    else nextState = loop;
        default: nextState = finished;
        endcase
    end

    always_comb
    begin
        case(state)
        finished: controlSignals = { 4'b0000 };
        reset1: controlSignals = { 1'b1, 1'b1, 2'b00 };
        reset2: controlSignals = { 1'b0, 1'b1, 2'b00 };
        loop: controlSignals = { 4'b0100 };
        endcase
    end

    always_ff @(posedge clk)
    begin
        state <= nextState;
    end

endmodule