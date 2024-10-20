`timescale 1ns / 1ps
`define SDFFILE    "../pre_sim/nonpipeline/dc_out_file/hw2_nonpipeline_syn.sdf"

module nonpipeline_pre_tb;
    reg  [7:0] a, b, c;     
    reg  s;      
    wire [15:0] d;        

    reg [15:0] ans; 
    integer i, error = 0;          
    integer non_zero_c_count = 0; 
    integer zero_c_count = 0; 
    
    hw2_nonpipe uut (a, b, c, s, d);

    `ifdef SDF_FILE
        initial $sdf_annotate(`SDF_FILE, uut);
    `endif

    initial begin
        non_zero_c_count = 0;
        zero_c_count = 0;
        
        for (i=0; i<200; i=i+1) begin
            a = $random % 256;
            b = $random % (a + 1);
            s = $random % 2;

            if (zero_c_count < 100 && non_zero_c_count >= 100) begin
                c = 0;
            end
            else if (non_zero_c_count < 100 && zero_c_count >= 100) begin
                c = $random % 255 + 1;
            end
            else begin
                if ($random % 2 == 0) begin
                    c = 0;
                end else begin
                    c = $random % 255 + 1;
                end
            end

            if (c == 0)
                zero_c_count = zero_c_count + 1;
            else
                non_zero_c_count = non_zero_c_count + 1;
            
            if (s) begin
                ans = (a + b) * c;
            end else begin
                ans = (a - b) * c;
            end
            #5;
            if (ans != d) begin
                error = error + 1;
            end
            $display("Time:%d | a = %d, b = %d, c = %d, s = %b, output d = %d, expected d = %d", i+1, a, b, c, s, d, ans);
            
        end
        if (error) begin
            $display("You have %d errors!", error);
        end else begin
            $display("All test data correct!");
        end
        $finish;
    end

endmodule
