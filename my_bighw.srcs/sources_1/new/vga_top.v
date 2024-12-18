`timescale 1ps/1ps
module vga_top(
    input clk,
    input clr_n,
    
    //input [8:0] write_row,
    //input [9:0] write_col,
    //input [8:0] write_data,
    //input write_en,
    output rdn,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b,
    output hsync,
    output vsync

);

    wire [18:0] wt_addr;
    wire [8:0] wt_data;
    wire [18:0] rd_addr;
    wire [8:0] data_in;
    wire wena;
    wire clk_out;
    reg [9:0] col=0;
    reg [8:0] row=0;
    reg [8:0] data=9'b101010101;
    reg ena_reg=1;
    reg [32:0] count=0;
    assign wena=ena_reg;
    assign wt_addr = {row,col};
    assign wt_data = data;
    
    clk_wiz_0 clk_inst(
        .clk_in1(clk),
        .clk_out1(clk_out)
    );
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
            .clka(clk),
            .dina(wt_data),
            .ena(1'b1),
            .wea(wena),

            .addrb(rd_addr),
            .clkb(clk_out),
            .doutb(data_in),
            .enb(~rdn)
        );
//    always @ (negedge hsync) begin
//        if (count==1) begin
//            count<=0;
//        end else if(count==0) begin
//            if(row==480&& col==640) begin
//                row<=0;
//                col<=0;
//                count<=count+1;

//            end else begin
//                if(col==640)begin
//                    col<=0;
//                    row<=row+1;
//                    data<=data+1;
                
//                end else begin
//                    col<=col+1;
//                end 
//            end    

        
//        end else begin
//            count<=count +1 ;
//        end
//    end 
   
endmodule