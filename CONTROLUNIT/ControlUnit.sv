

module ControlUnit(
    input logic         clk,
    input logic         reset,

    input logic         inHoldFromExecute,
    input logic         inHoldFromDataMemory,
    input logic         inJMPSignal,

    input logic [15:0]  inNewInstructionAddress,

    output logic        outReset,
    output logic        outHoldDecode,
    output logic        outFlushDecode,
    output logic        outHoldExecute,
    output logic        outFlushExecute,
    output logic        outHoldDataMemory,
    output logic        outFlushDataMemory,

    output logic [15:0] outInstructionAddress
);
    typedef enum logic [2:0] { 
        reset_1, 
        reset_2, 
        run,
        hold_execute,
        hold_dataMemory,
        jump
    } statetype;

    statetype currentState, nextState;

    always_ff @(posedge clk)
    begin
        if(reset)   
        begin
            outInstructionAddress <= 16'h0000;
            currentState <= reset_1;
        end
        else
        begin
            currentState <= nextState;
            if(nextState == run)
                outInstructionAddress <= outInstructionAddress + 2;
            else if(nextState == jump)
                outInstructionAddress <= inNewInstructionAddress;
            else 
                outInstructionAddress <= outInstructionAddress;
        end
    end

    always_comb
    begin
        case(currentState)
            reset_1: nextState = reset_2;
            reset_2: nextState = run;

            run: 
                if(inHoldFromDataMemory)    nextState = hold_dataMemory;
                else if(inHoldFromExecute)  nextState = hold_execute;
                else if(inJMPSignal)        nextState = jump;
                else                        nextState = run;

            jump:
                if(inHoldFromDataMemory)    nextState = hold_dataMemory;
                else if(inHoldFromExecute)  nextState = hold_execute;   
                else if(inJMPSignal)        nextState = jump;
                else                        nextState = run;

            hold_execute:
                if(inHoldFromDataMemory)    nextState = hold_dataMemory;
                else if(inHoldFromExecute)  nextState = hold_execute;
                else if(inJMPSignal)        nextState = jump;
                else                        nextState = run;

            hold_dataMemory:
                if(inHoldFromDataMemory)    nextState = hold_dataMemory;
                else if(inHoldFromExecute)  nextState = hold_execute;
                else if(inJMPSignal)        nextState = jump;
                else                        nextState = run;
        endcase
    end

    always_comb
    begin
        case(currentState)
            reset_1: 
                begin
                    outReset = 1;
                    outHoldDecode = 0;
                    outFlushDecode = 0;
                    outHoldExecute = 0;
                    outFlushExecute = 0;
                    outHoldDataMemory = 0;
                    outFlushDataMemory = 0;
                end
            reset_2:
                begin
                    outReset = 0;
                    outHoldDecode = 0;
                    outFlushDecode = 0;
                    outHoldExecute = 0;
                    outFlushExecute = 0;
                    outHoldDataMemory = 0;
                    outFlushDataMemory = 0;
                end
            run:
                begin
                    outReset = 0;
                    outHoldDecode = 0;
                    outFlushDecode = 0;
                    outHoldExecute = 0;
                    outFlushExecute = 0;
                    outHoldDataMemory = 0;
                    outFlushDataMemory = 0;
                end
            hold_dataMemory:
                begin
                    outReset = 0;
                    outHoldDecode = 1;
                    outFlushDecode = 0;
                    outHoldExecute = 1;
                    outFlushDecode = 0;
                    outHoldDataMemory = 1;
                    outFlushDataMemory = 0;
                end
            hold_execute:
                begin
                    outReset = 0;
                    outHoldDecode = 1;
                    outFlushDecode = 0;
                    outHoldExecute = 1;
                    outFlushExecute = 0;
                    outHoldDataMemory = 0;
                    outFlushDataMemory = 0;
                end
            jump:
                begin
                    outReset = 0;
                    outHoldDecode = 0;
                    outFlushDecode = 0;
                    outHoldExecute = 0;
                    outFlushExecute = 1;
                    outHoldDataMemory = 0;
                    outFlushDataMemory = 1;
                end
        endcase
    end

endmodule