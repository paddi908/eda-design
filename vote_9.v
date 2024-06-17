module vote_9(
    input   [8:0]   vote,
    input   clk,
    output  reg result,
    output  reg [8:0]   vote_out
    );

    wire    [3:0]  agree;
    wire    [3:0]  disagree;

    assign agree = vote[0]+vote[1]+vote[2]+vote[3]+vote[4]
                +vote[5]+vote[6]+vote[7]+vote[8];
    //assign disagree = ~vote[0]+~vote[1]+~vote[2]+~vote[3]+~vote[4]
      //          +~vote[5]+~vote[6]+~vote[7]+~vote[8];
    
    //assign result = (sum > 4'b0100) ? 1'b1 : 1'b0;

    always@(posedge clk)begin
        vote_out = vote;
        if(agree > 4'b0100)
            result = 1'b1;
        else
            result = 1'b0;
    end
    
endmodule