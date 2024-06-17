module top(
    input clk,
    input [8:0] vote,
    input LD10, // 声明LD10作为输入
    output [10:0] LD,
    output [3:0] seg_light,
    output [7:0] seg
);

    // 内部信号声明
    wire result;
    wire [3:0] agree;
    wire [3:0] disagree;
    wire [7:0] seg_clear;
    wire [7:0] seg_dis;
    wire [9:0] vote_out;
    wire [9:0] clear_out;
    reg [9:0] LD_internal;
    reg [9:0] seg_internal = 10'b1111111111;
    // 连接内部信号
    assign agree = vote[0]+vote[1]+vote[2]+vote[3]+vote[4]
                +vote[5]+vote[6]+vote[7]+vote[8];
    assign disagree = 9 - agree;
    //assign LD[10]=LD10;

    pll0 C8(.cin(clk), .cout(clk_8));
    

    // 实例化vote_9模块
    vote_9 voting_system (
        .vote(vote),
        .clk(clk),
        .result(result),
        .vote_out(vote_out) // 确保这里连接正确
    );

    // 实例化seg_7模块
    seg_7 display (
        .clk(clk),
        .clk_8(clk_8),
        .agree(agree),
        .disagree(disagree),
        .seg_tube(seg_dis),
        .seg_light(seg_light)
    );

    // 实例化check_result模块
    check_result result_check (
        .result(result),
        .clk(clk),
        .LD9(LD[9]) // 将result连接到LD[9]
    );

    // 实例化clear模块
    clear reset (
        .LD10(LD10), // 使用外部输入LD10
        .clk(clk),
        .LD(clear_out),
        .seg(seg_clear)
    );

    // 多路选择器逻辑
    always @(*) begin
        if (LD10) begin
            LD_internal <= clear_out;
            seg_internal <= seg_clear;
        end else begin
            LD_internal <= vote_out;
            //LD_internal[9] <= result;
            seg_internal <= seg_dis;
        end
    end
    

        assign LD[9:0] = LD_internal;
        assign LD[10] = LD10;
        assign seg[7:0] = seg_internal;


endmodule
