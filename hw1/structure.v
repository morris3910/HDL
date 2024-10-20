module adder_structure (s, co, a, b, ci);
    parameter N = 32;
    output [N-1:0] s;
    output co;
    input [N-1:0] a, b;
    input ci;
    wire [N:0] c;

    assign c[0] = ci;

    genvar i;
    generate
        for(i = 0; i < N; i=i+1)
            begin:FA_loop
                FA fa(s[i], c[i+1], a[i], b[i], c[i]);
            end
    endgenerate
    assign co = c[N];

endmodule