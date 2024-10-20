`timescale 1ns/10ps

module RCA_post_tb;
    reg [31:0] a;
    reg [31:0] b;
    reg ci;
    reg [32:0] ans;
    reg clk;
    wire [31:0] s1, s2, s3, s4, s5, s6;
    wire co1, co2 ,co3, co4, co5, co6;
    integer i, error; 

    adder_structure structure (s1, co1, a, b, ci);
    adder_dataflow dataflow (s2, co2, a, b, ci);
    adder_behavior behavior (s3, co3, a, b, ci);
    adder_structure_reg structure_reg (s4, co4, a, b, ci, clk);
    adder_dataflow_reg dataflow_reg (s5, co5, a, b, ci, clk);
    adder_behavior_reg behavior_reg (s6, co6, a, b, ci, clk);

    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_structure.sdf", structure);
    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_structure_reg.sdf", structure_reg);
    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_dataflow.sdf", dataflow);
    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_dataflow_reg.sdf", dataflow_reg);
    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_behavior.sdf", behavior);
    initial $sdf_annotate("/home/B103040021_HDL/dc_out_file/adder_behavior_reg.sdf", behavior_reg);

    always begin
        #5 clk = ~clk;
    end

    initial begin
        a = 0;
        b = 0;
        ci = 0; 
        clk = 0;
        error = 0;
        
        for (i = 0; i < 10; i = i + 1) begin
            a = $random%(2**31);   
            b = $random%(2**31);
            ci = $random % 2; 
            ans = a + b + ci;
            #10;
            if(ans[31:0] != s1 || ans[32] != co1)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at structure #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s1);
                $display("Your cout output  : %b\n", co1);
                $display("----------------------------------------\n");
            end
            if(ans[31:0] != s2 || ans[32] != co2)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at dataflow #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s2);
                $display("Your cout output  : %b\n", co2);
                $display("----------------------------------------\n");
            end
            if(ans[31:0] != s3 || ans[32] != co3)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at behavior #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s3);
                $display("Your cout output  : %b\n", co3);
                $display("----------------------------------------\n");
            end
            if(ans[31:0] != s4 || ans[32] != co4)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at structure_reg #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s4);
                $display("Your cout output  : %b\n", co4);
                $display("----------------------------------------\n");
            end
            if(ans[31:0] != s5 || ans[32] != co5)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at dataflow_reg #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s5);
                $display("Your cout output  : %b\n", co5);
                $display("----------------------------------------\n");
            end
            if(ans[31:0] != s6 || ans[32] != co6)
            begin
                error = error + 1;
                $display("----------------------------------------\n");
                $display("Output error at behavior_reg #%d\n", i+1);
                $display("The input A  is   : %b\n", a);
                $display("The input B  is   : %b\n", b);
                $display("The input Ci is   : %b\n", ci);
                $display("The sum answer is : %b\n", ans[31:0]);
                $display("The cout answer is: %b\n", ans[32]);
                $display("Your sum output   : %b\n", s6);
                $display("Your cout output  : %b\n", co6);
                $display("----------------------------------------\n");
            end
        end
        if (error == 0) 
        begin
            $display("----------------------------------------\n");
            $display("All testdata correct!\n");
            $display("----------------------------------------\n");
        end
        $finish;
    end
endmodule