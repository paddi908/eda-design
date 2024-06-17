module check_result(
    input   result,
    input   clk,
    output reg  LD9
);
    always@(posedge clk)begin
        if(result == 1'b1)
            LD9 = 1;
        else
            LD9 = 0;
    end
endmodule