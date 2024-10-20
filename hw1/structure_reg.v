module adder_structure_reg (s, co, a, b, ci, clk);
    parameter N = 32;
    output [N-1:0] s;
    output co;
    input [N-1:0] a, b;
    input ci, clk;
    wire [N-1:0] sum;
    wire c_out;

    adder_structure uut4 (sum, c_out, a, b, ci);
    D_FF utt5 (s, sum, clk);
    D_FF_1 utt6 (co, c_out, clk);
endmodule