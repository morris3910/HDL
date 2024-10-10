module FA (sum, c_out, a, b, c_in);
    output sum;
    output c_out;
    input a, b;
    input c_in;
    wire c1, s1, s2;

    xor(s1, a, b);
    and(c1, a, b);
    xor(sum, c_in, s1);
    and(s2, c_in, s1);
    xor(c_out, c1, s2);
endmodule