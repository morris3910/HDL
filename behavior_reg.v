module adder_behavior_reg (s, co, a, b, ci, clk);
    parameter N = 32;
    output [N-1:0] s;
    output co;
    input [N-1:0] a, b;
    input ci, clk;
    wire [N-1:0] sum;
    wire c_out;

    adder_behavior utt13 (sum, c_out, a, b, ci);
    D_FF_1 utt14 (co, c_out, clk);
    D_FF utt15 (s, sum, clk);

endmodule