

module Control(
    input logic clk,
    input logic reset,
    input logic MSB,
    output logic [9:0] signals,
    output logic finished
);

    logic [4:0] counter;
    
    typedef enum logic [4:0] {
        init1, init2, shift1, shift2, sub1, smaller1, 
        smaller2, larger1, larger2, final1
    } statetype;
    statetype state, nextState;

    always_ff @(posedge clk)
    begin
        if(reset)
        begin
            state <= init1;
            counter <= 5'b1_1111;
        end
        else if(nextState == sub1)
        begin 
            counter <= counter + 1;
            state <= nextState;

        end
        else state <= nextState;
    end
            
    always_comb
    begin
        case(state)
        init1: nextState = init2;
        init2: nextState = shift1;
        shift1: nextState = shift2;
        shift2: nextState = sub1;
        sub1:
            if(counter == 16) nextState = final1;
            else if(MSB) nextState = smaller1;
            else nextState = larger1;

        smaller1: nextState = smaller2;
        larger1: nextState = larger2;
        smaller2:   if(counter == 15) nextState = final1;
                    else nextState = sub1;

        larger2:    if(counter == 15) nextState = final1;
                    else nextState = shift1;

        final1: nextState = final1;
        default: nextState = init1;
        endcase
    end

    logic [3:0] localCounter;
    assign localCounter = counter[3:0];

    always_comb
    begin
        case(state)
        init1: signals = 10'b01_0001_0000;
        init2: signals = 10'b11_0011_0000;
        shift1: signals = { 6'b0001_00, localCounter };
        shift2: signals = { 6'b1001_00, localCounter };
        sub1: signals = { 6'b00_0000, localCounter };
        smaller1: signals = { 6'b0001_00, localCounter };
        smaller2: signals = { 6'b1001_10, localCounter };
        larger1: signals = { 6'b0010_00, localCounter };
        larger2: signals = { 6'b1010_10, localCounter };
        final1: signals = 10'b00_0000_0000;
        endcase
    end

    assign finished = (state == final1);

endmodule