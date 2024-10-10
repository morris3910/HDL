module D_FF_1 (q, d, clk);
    output reg q;
    input d, clk;

    always @(posedge clk) 
    begin
        q <= d;    
    end
endmodule

module D_FF (q, d, clk);
    output [31:0] q;
    input [31:0] d;
    input clk;

    genvar i;
    generate
        for (i = 0;i < 32 ; i=i+1) 
        begin : D_FF_loop
            D_FF_1 utt8 (q[i], d[i], clk);
        end
    endgenerate
endmodule