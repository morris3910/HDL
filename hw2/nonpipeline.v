module hw2_nonpipe(
    input  [7:0] a, b, c, 
    input  s,   
    output [15:0] d   
);
    assign d = (s) ? (a+b)*c : (a-b)*c;
endmodule
