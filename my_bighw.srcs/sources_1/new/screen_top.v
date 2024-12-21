`timescale 1ps/1ps
module screen_top(
    input wire clk_out,
    input wire rst_n,
    input wire rst_scrn_bfr,
    input [7:0] wt_data_in,
    input wt_en,
    input wire clr_n,
    input wire next_line,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b,

    output hsync,
    output vsync

);

    reg this_next_line;
    reg last_next_line;
    wire next_line_wire;
    assign next_line_wire =this_next_line&&~last_next_line;

    reg this_wt_en;
    reg last_wt_en;
    wire wt_en_vga_wire;
    assign wt_en_vga_wire = this_wt_en&&~last_wt_en;

    reg [6:0]scrn_bfr_col=0;
    reg [4:0]scrn_bfr_row=0;
    reg rst_n_reg=1;

    wire rst_n_wire ;
    wire [6:0] scrn_bfr_col_wire;
    wire [4:0] scrn_bfr_row_wire;
    assign scrn_bfr_col_wire = scrn_bfr_col;
    assign scrn_bfr_row_wire = scrn_bfr_row;
    
    wire wt_en_vga_wire;
    wire [18:0] wt_addr_vga_out_wire;
    wire [8:0] wt_data_out_wire;

    wire [18:0] bg_rom_addr_wire;

    wire [8:0] bg_rom_data_wire;
    
    wire [8:0] test;
    assign rst_n_wire = rst_n_reg&&rst_n;

    always @ (posedge clk_out) begin
        if(rst_n)begin
            this_next_line <= next_line;
            last_next_line <= this_next_line;
        end
        else begin
            this_next_line<=0;
            last_next_line<=0;
        end
    end
    
    always @ (posedge clk_out )begin
        if(rst_n)begin
            this_wt_en <= wt_en;
            last_wt_en <= this_wt_en;
        end
        else begin
            this_wt_en<=0;
            last_wt_en<=0;
        end
    end
            

    always @ (posedge clk_out) begin
        if(rst_scrn_bfr) begin
            scrn_bfr_col <= 0;
            scrn_bfr_row <= 0;
        end
    end
    
    always @ (posedge clk_out )begin
        if(~rst_n)begin
            scrn_bfr_col <= 0;
            scrn_bfr_row <= 0;
        end
    end

    always @ (posedge clk_out )begin
        if(rst_n&&wt_en_vga_wire)begin
            if(next_line_wire)begin
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
            end
        end else begin
            scrn_bfr_col<=scrn_bfr_col;
            scrn_bfr_row<=scrn_bfr_row;
            rst_n_reg <= 1;
        end
    end


    assign test=bg_rom_data_wire;
    background_rom bg_rom(
        .addra(bg_rom_addr_wire),
        .clka(clk_out),
        .douta(bg_rom_data_wire)
    );


    vga_top vga_top_inst(
        .clk_out(clk_out),
        .clr_n(clr_n),
        .wt_data(wt_data_out_wire),
        .wena(wt_en_vga_wire),
        .wt_addr(wt_addr_vga_out_wire),
        .hsync(hsync),
        .vsync(vsync),
        .r(r),
        .g(g),
        .b(b)
    );
    convert_to_vga convert_to_vga_inst(
        .clk_out(clk_out),
        .rst_n(rst_n_wire),
        .wt_en(wt_en),

        .scrn_bfr_col(scrn_bfr_col_wire),
        .scrn_bfr_row(scrn_bfr_row_wire),
        .wt_data_in(wt_data_in),

        .wt_en_vga(wt_en_vga_wire),
        .wt_addr_vga_out(wt_addr_vga_out_wire),
        .wt_data_out(wt_data_out_wire),

        .bg_rom_addr(bg_rom_addr_wire),
        .bg_rom_data(bg_rom_data_wire)
    );

endmodule