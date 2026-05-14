

module ALUControl(
    // control inputs
    input logic clk,
    input logic divFinished,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,

    // forward path
    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    input logic [3:0] srcRegister1,
    input logic [3:0] srcRegister2,

    // data outputs
    output logic [3:0] controlSignals,
    output logic [15:0] outData1,
    output logic [15:0] outData2
);  
    logic multiCycle;


    assign outData1 = |(forwardPathInputExecuteSrc ^ srcRegister1) ? inData1: forwardPathInputExecute;
    assign outData1 = |(forwardPathInputDataMemorySrc ^ srcRegister1) ? inData1: forwardPathInputDataMemory;

    assign outData2 = |(forwardPathInputExecuteSrc ^ srcRegister2) ? inData1: forwardPathInputExecute;
    assign outData2 = |(forwardPathInputDataMemorySrc ^ srcRegister2) ? inData1: forwardPathInputDataMemory;


    always_comb
    begin 
        case(operation)
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

    /*
        controlSignals
        0: reset,
        1: hold
    */

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