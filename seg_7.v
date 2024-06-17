module seg_7(
    input clk,
    input clk_8,
    input   [3:0]   agree,
    input   [3:0]   disagree,
    output  reg  [7:0]   seg_tube,
    output  reg [3:0]   seg_light
);

    reg [3:0]   seg_sel = 4'b0001;
    reg [7:0]   show_number[3:0];
    
    always@(posedge clk_8)begin
        show_number[0]=transform(disagree[3:0]);
        show_number[1]=transform({4'b0});
        show_number[2]=transform(agree[3:0]);
        show_number[3]=transform({4'b0});        
        
        case(seg_sel)
            4'b0001:seg_tube = show_number[0];
            4'b0010:seg_tube = show_number[1];
            4'b0100:seg_tube = show_number[2];
            4'b1000:seg_tube = show_number[3];
        endcase    
        seg_light = seg_sel;
    end

    integer i;

    always@(posedge clk_8)begin
        if(seg_sel == 4'b1000)begin
            seg_sel <= 4'b0001;
        end
        else begin
            seg_sel <= seg_sel<<1'b1;
        end
    end



    function[7:0]   transform;
        input   [3:0]   x;
        reg [7:0]   show_reg;
        begin
            case(x)
                4'd00:   show_reg=8'b11000000;
                4'd01:   show_reg=8'b11111001;
                4'd02:   show_reg=8'b10100100;
                4'd03:   show_reg=8'b10110000;
                4'd04:   show_reg=8'b10011001;
                4'd05:   show_reg=8'b10010010;
                4'd06:   show_reg=8'b10000010;
                4'd07:   show_reg=8'b11111000;
                4'd08:   show_reg=8'b10000000;
                4'd09:   show_reg=8'b10010000;
                default: show_reg=8'b11111111;                 
            endcase
            transform = show_reg;
        end
    endfunction

endmodule