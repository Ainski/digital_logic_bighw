`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/05 04:50:39
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb;
// module top(
//     input wire clk_in,
//     input wire rst_n,
//     input wire PS2D,
//     input wire PS2C,

//     output [3:0] r,
//     output [3:0] g,
//     output [3:0] b,

//     output hsync,
//     output vsync
// );
reg clk_in;
reg rst_n;
reg ps2d;
reg ps2c;

wire [3:0] r;
wire [3:0] g;
wire [3:0] b;

wire hsync;
wire vsync;

top top_inst(
   .clk_in(clk_in),
   .rst_n(rst_n),
   .PS2D(ps2d),
   .PS2C(ps2c),

   .r(r),
   .g(g),
   .b(b),

   .hsync(hsync),
   .vsync(vsync)
);

initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n = 1;
    #40 rst_n = 0;
    #40 rst_n = 1;
end
initial begin
    ps2c=1;
    forever #100 ps2c=~ps2c;
end
initial begin
    ps2d=1;
    #10000 ps2d=1;
     #2000//mov 键码
        //3a 'm'
        ps2d=0;//begin

        #200 ps2d = 0 ;
        #200 ps2d = 1 ;
        #200 ps2d = 0 ;
        #200 ps2d = 1;
        #200 ps2d=1;
        #200 ps2d=1;
        #200 ps2d=0;
        #200 ps2d=0;//content

        #200 ps2d=0;//奇偶校验�??????
        #200 ps2d=1;//end

        //f0
        #1000 ps2d =0 ;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1 ;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0 ;
        #200 ps2d = 1 ;

        //3a
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //31 'o'
        #2000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0;
        #200 ps2d = 1;


        //31
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //2A 'v'
        #2000 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0;
        #200 ps2d = 1;

        //2A
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        
        #200 ps2d = 1;
        #200 ps2d = 1;

        //' '
        //29
        #2000 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000
        ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //29
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;


        //'a'
        //1c
        #2000 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //1c
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //' '
        //29
        #2000 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //29
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //'b'
        //32
        #2000 ps2d = 0;

        #200 ps2d = 0; 
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //32
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        // //' '
        // //29
        // #2000 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 1;

        // //f0
        // #1000 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 1;
        // #200 ps2d = 1;
        // #200 ps2d = 1;

        // #200 ps2d = 0;
        // #200 ps2d = 1;

        // //29
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 1;

        //'\n'
        //5A 
        #2000 ps2d =0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1 ;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //5A
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        
    #100000000 $finish;
end


endmodule
