
// asynchronous reset
// a posedge for rest, meaning a switch from 0 to 1, will trigger the flipflop immediately to reset state 

// module rflipflop(
//     input logic clk,
//     input logic reset,
//     input logic [3:0] d,
//     output logic [3:0] q
// );

//     // sensitivity list  
//     always_ff @(posedge clk, posedge reset)
//         if (reset) q<= 4'b0;
//         else q <= d;
// endmodule;

// synchronous rest

module rflipflop(
    input logic clk,
    input logic reset,
    input logic [3:0] d,
    output logic [3:0] q
);

    always_ff @(posedge clk)
        if(reset) q<= 4'b0;
        else q <= d;
endmodule;