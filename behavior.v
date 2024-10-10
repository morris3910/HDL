module adder_behavior (s, co, a, b, ci);
    parameter N = 32;
    output reg [N-1:0] s;
    output reg co;
    input [N-1:0] a, b;
    input ci;

    always @(*) 
    begin
        {co, s} = a + b + ci;
    end
endmodule