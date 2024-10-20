`timescale 1ns / 1ps
`define CYCLE 10.0
`define SDFFILE    "../pre_sim/pipeline/dc_out_file/hw2_pipeline_syn.sdf"

module pipeline_pre_tb;
    reg  [7:0] a, b, c;  
    reg  s, clk, rst; 
    wire [15:0] d;  

    reg [7:0] a_pipeline [0:199];
    reg [7:0] b_pipeline [0:199];
    reg [7:0] c_pipeline [0:199];
    reg s_pipeline [0:199];
    reg [15:0] expected_ans;
    integer i, error = 0;       
    integer non_zero_c_count = 0;
    integer zero_c_count = 0; 

    hw2_pipe uut (a, b, c, s, clk, rst, d);

    `ifdef SDF_FILE
        initial $sdf_annotate(`SDF_FILE, uut);
    `endif

    always begin #(`CYCLE/2) clk = ~clk; end 

    function [7:0] generate_c;
        input integer non_zero_c_count, zero_c_count;
        begin
            if (zero_c_count < 100 && non_zero_c_count >= 100) begin
                generate_c = 0;
            end
            else if (non_zero_c_count < 100 && zero_c_count >= 100) begin
                generate_c = $random % 255 + 1;
            end
            else begin
                if ($random % 2 == 0) begin
                    generate_c = 0;
                end else begin
                    generate_c = $random % 255 + 1;
                end
            end
        end
    endfunction

    initial begin
        clk = 0;
        rst = 1;
        non_zero_c_count = 0;
        zero_c_count = 0;

        #(`CYCLE*2);
        rst = 0; 

        for (i=0; i<200+2-1; i=i+1) begin
            a = $random % 256;
            b = $random % (a + 1);
            s = $random % 2;
            c = generate_c(non_zero_c_count, zero_c_count);

            if (c == 0)
                zero_c_count = zero_c_count + 1;
            else
                non_zero_c_count = non_zero_c_count + 1;

            a_pipeline[i] = a;
            b_pipeline[i] = b;
            s_pipeline[i] = s;
            c_pipeline[i] = c;

            #(`CYCLE);

            if (i >= 2-1) begin
                expected_ans = (s_pipeline[i-2+1]) ? (a_pipeline[i-2+1]+b_pipeline[i-2+1])*c_pipeline[i-2+1] : (a_pipeline[i-2+1]-b_pipeline[i-2+1])*c_pipeline[i-2+1];
                if (expected_ans != d) begin
                    error = error + 1;
                end
                $display("Time %d | a = %d, b = %d, c = %d, s = %b | output d = %d | Expected d = %d", i, a_pipeline[i-2+1], b_pipeline[i-2+1], c_pipeline[i-2+1], s_pipeline[i-2+1], d, expected_ans);
            end
        end
        if (error) begin
            $display("You have %d errors !", error);
        end else begin
            $display("All test data correct !");
        end
        $finish;
    end

endmodule
