module clear(
    input   LD10,
    input   clk,
    output  reg [9:0]   LD,
    output  reg [7:0]   seg
);
    always@(posedge clk)begin
        if(LD10 == 1'b1)begin
            LD[9:0] <= 10'b0000000000;
            seg[7:0] <= 8'b01000000;
        end
        else begin
            LD=LD;
            seg=seg;
        end
    end
endmodule