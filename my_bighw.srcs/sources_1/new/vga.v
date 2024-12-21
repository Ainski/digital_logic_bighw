`timescale 1ps/1ps
module vga (
    input clk,//50MHz clock
    input clr_n,//active low clear

    input [8:0] data_in,

    output [18:0] rd_addr,//pixel address for reading from ram 1440(2048)*900(1024)
    output rdn, //active high read enable signal

    
    output [3:0] r,
    output [3:0] g,
    output [3:0] b,

    output hsync,
    output vsync//vertical and horizontal sync signals


);
    parameter H_RES = 640;//horizontal resolution
    parameter H_FP = 16;//horizontal front porch
    parameter H_SYNC = 96;//horizontal sync width
    parameter H_BP = 48;//horizontal back porch
    parameter H_ALL = H_RES + H_FP + H_SYNC + H_BP;


    parameter V_RES = 480;//vertical resolution
    parameter V_FP = 10;//vertical front porch
    parameter V_SYNC = 2;//vertical sync width
    parameter V_BP = 33;//vertical back porch
    parameter V_ALL = V_RES + V_FP + V_SYNC + V_BP;
    

    reg vga_clk=0;//25MHz clock
    reg [8:0] data_reg;//data register for input data
    reg video_out;//video output enable
    
    reg [9:0] h_count;//horizontal pixel count(0-1440)
    reg [8:0] v_count;// vertical pixel count(0-900)

    always @(posedge clk or negedge clr_n) begin
        if(clr_n==0)begin
            vga_clk <= 0;
        end else begin
            vga_clk <= ~vga_clk;
        end
    end

    always @ (posedge vga_clk or negedge clr_n) begin
        if(clr_n==0)begin
            h_count <= 0;
        end else if (h_count == H_ALL-1) begin
            h_count <= 0;
        end else begin
            h_count <= h_count + 1;
        end
    end

    always @ (posedge vga_clk or negedge clr_n) begin
        if(clr_n==0)begin
            v_count <= 0;
        end else if (h_count == H_ALL-1) begin
            if (v_count == V_ALL-1) begin
                v_count <= 0;
            end else begin
                v_count <= v_count + 1;
            end
        end
    end


    always @ (posedge vga_clk or negedge clr_n) begin
        if(clr_n==0)begin
            data_reg <= 0;
            video_out <= 0;
        end else begin
            video_out <=~rdn;
            data_reg <=data_in;
        end
    end


    assign rdn = ~(((h_count >= H_FP+H_SYNC)&&(h_count < H_ALL-H_BP))&&(v_count >= V_FP+V_SYNC)&&(v_count < V_ALL-V_BP));

    wire [8:0] row = v_count-V_FP-V_SYNC;
    wire [9:0] col = h_count-H_FP-H_SYNC;

    assign rd_addr ={row,col};

    assign hsync = (h_count >= H_SYNC);
    assign vsync = (v_count >= V_SYNC);

    assign r = (video_out)? {data_reg[8:6],1'b1} : 4'b0000;
    assign g = (video_out)? {data_reg[5:3],1'b1}:  4'b0000;
    assign b = (video_out)? {data_reg[2:0],1'b1} : 4'b0000;
//    assign r = h_count[9:6];
//    assign g = h_count[6:3];
//    assign b = h_count[3:0];
endmodule
