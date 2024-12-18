`timescale 1ps /1ps
module vga_top_tb();
    
    reg clk;
    reg clr_n;
    wire rdn;
    wire [3:0] r;
    wire [3:0] g;
    wire [3:0] b;
    wire hsync;
    wire vsync;

    vga_top vga_top_inst(
       .clk(clk),
       .clr_n(clr_n),
       .rdn(rdn),
       .r(r),
       .g(g),
       .b(b),
       .hsync(hsync),
       .vsync(vsync)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        clr_n = 0;
        #100 clr_n = 1;
        #1000000 $finish;
    end

    
endmodule