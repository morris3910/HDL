module adder_dataflow_reg (s, co, a, b, ci, clk);
    parameter N = 32;
    output [N-1:0] s;
    output co;
    input [N-1:0] a, b;
    input ci, clk;
    wire [N-1:0] sum;
    wire c_out;

    adder_dataflow utt9 (sum, c_out, a, b, ci);
    D_FF_1 utt10 (co, c_out, clk);
    D_FF utt11 (s, sum, clk);
endmodule