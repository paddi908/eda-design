`timescale 1ns / 1ps

module top_tb;

    // Inputs
    reg [8:0] vote;
    reg clk;
    reg LD10;

    // Outputs
    wire [10:0] LD;
    wire [3:0] seg_light;
    wire [7:0] seg;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .clk(clk),
        .vote(vote),
        .LD10(LD10),
        .LD(LD),
        .seg_light(seg_light),
        .seg(seg)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with 10ns period
    end

    // Random stimulus
    initial begin
        // Initialize Inputs
        vote = 9'b000000000;
        LD10 = 0;
        // Wait for global reset
        #1000;
        
        // Random test sequence
        repeat (1000) begin
            // Random vote pattern
            vote = $random;
            #1000;
            
            // Random clear signal
            LD10 = $random % 2;
            #100;
            
            // Deactivate clear
            LD10 = 0;
            #100;
        end
        
        // Finish simulation
        $finish;
    end
      
endmodule
