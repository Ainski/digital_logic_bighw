`timescale 1ps/1ps
module screen_top(
    input wire clk_out,
    input wire rst_n,
    input [7:0] wt_data_in,
    input wire wt_en,

    output [3:0] r,
    output [3:0] g,
    output [3:0] b,

    output hsync,
    output vsync

);
    reg [6:0]scrn_bfr_col=0;
    reg [4:0]scrn_bfr_row=0;
    reg rst_n_reg=1;

    wire rst_n_wire ;
    assign rst_n_wire = rst_n_reg&&rst_n;

    always @ (posedge clk_out )begin
        if(~rst_n)begin
            scrn_bfr_col <= 0;
            scrn_bfr_row <= 0;
        end
    end

    always @ (posedge clk_out )begin
        if(rst_n&&wt_en)begin
            if(scrn_bfr_col==79)begin
                if(scrn_bfr_row==29)begin
                    scrn_bfr_col <= 0;
                    scrn_bfr_row <= 0;
                    rst_n_reg <= 0;
                end else begin
                    scrn_bfr_col <= 0;
                    scrn_bfr_row <= scrn_bfr_row + 1;
                    rst_n_reg <= 1;
                end
            end else begin
                scrn_bfr_col <= scrn_bfr_col + 1;
                rst_n_reg <= 1;
            end
        end else begin
            rst_n_reg <= 1;
        end
    end

    wire [6:0] scrn_bfr_col_wire;
    wire [4:0] scrn_bfr_row_wire;
    
    wire [7:0] wt_data_in_wire;
    
    wire wt_en_vga_wire;
    wire [18:0] wt_addr_vga_out_wire;
    wire [8:0] wt_data_out_wire;

    wire [18:0] bg_rom_addr_wire;
    wire bg_rom_addr_ena_wire;
    wire [8:0] bg_rom_data_wire;

    background_rom bg_rom(
        .addra(bg_rom_addr_wire),
        .clka(clk_out),
        .douta(bg_rom_data_wire),
        .ena(bg_rom_addr_ena_wire)
    );


    vga_top vga_top_inst(
        .clk_out(clk_out),
        .clr_n(1'b1),
        .wt_data(wt_data_in_wire),
        .wt_en(wt_en_vga_wire),
        .wt_addr(wt_addr_vga_out_wire),
        .wt_data_out(wt_data_out_wire),
        .hsync(hsync),
        .vsync(vsync),
        .r(r),
        .g(g),
        .b(b)
    );






endmodule