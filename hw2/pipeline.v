module hw2_pipe (
    input  [7:0] a, b, c,
    input  s, clk, rst, 
    output [15:0] d 
);
    wire [8:0] result_stage1;

    stage1 s1 (a, b, s, clk, rst, result_stage1);

    reg [8:0] result_stage1_reg;
    reg [7:0] c_stage1_reg;
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            result_stage1_reg <= 0;
            c_stage1_reg <= 0;
        end else begin
            result_stage1_reg <= result_stage1;
            c_stage1_reg <= c;
        end
    end

    wire [15:0] result_stage2;
    wire [8:0] tmp_c = {1'b0, c_stage1_reg}; 
    stage2 s2 (result_stage1_reg, tmp_c, clk, rst, result_stage2);

    reg [15:0] result_stage2_reg;
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            result_stage2_reg <= 0;
        end else begin
            result_stage2_reg <= result_stage2;
        end
    end
    assign d = result_stage2_reg;

endmodule

module stage1 (
    input  [7:0] a, b,
    input  s, clk, rst,
    output reg [8:0] result
);
    always @ (*) begin
        if (s) begin
            result = a + b;
        end else begin
            result = a - b;
        end
    end

endmodule

module stage2 (
    input  [8:0] result_stage1,
    input  [8:0] c, 
    input  clk, rst, 
    output reg [15:0] result_stage2
);
    always @ (*) begin
        result_stage2 = result_stage1 * c;
    end

endmodule