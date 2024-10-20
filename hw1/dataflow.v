module adder_dataflow (s, co, a, b, ci);
    parameter N = 32;
    output [N-1:0] s;
    output co;
    input [N-1:0] a, b;
    input ci;

    assign {co, s} = a + b + ci;

endmodule