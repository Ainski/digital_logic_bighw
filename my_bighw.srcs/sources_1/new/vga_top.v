`timescale 1ps/1ps
module vga_top(
    input clk_out,
    input clr_n,

    input [8:0]wt_data,
    input [18:0]wt_addr,
    input wena,

    output [3:0] r,
    output [3:0] g,
    output [3:0] b,
    output hsync,
    output vsync
);
    wire [18:0] rd_addr ;
    wire [8:0] data_in;
    wire rdn;
    wire test;
    assign test=wena;
    wire [8:0]test_data;
    assign test_data=data_in;
    wire [18:0]test_addr;
    assign test_addr=rd_addr;
    vga vga_inst(
        .clk(clk_out),
        .clr_n(clr_n),
        .data_in(data_in),
        .rd_addr(rd_addr),
        .rdn(rdn),
        .r(r),
        .g(g),
        .b(b),
        .hsync(hsync),
        .vsync(vsync)
    );



    vga_ram vga_ram_inst(
        .addra(wt_addr),
        .clka(clk_out),
        .dina(wt_data),
        .ena(wena),
        .wea({wena}),
        .addrb(rd_addr),
        .clkb(clk_out),
        .doutb(data_in),
        .enb(1'b1)
     );
   
endmodule
