`timescale 1ps/1ps
module top(
    input wire clk_in,
    input wire rst_n,
    input wire PS2D,
    input wire PS2C,

    output [3:0] r,
    output [3:0] g,
    output [3:0] b,

    output hsync,
    output vsync,
    output [3:0] ax,
    output [3:0] bx,
    output [3:0] cx,
    output [3:0] dx,
    output cmprs
);
    wire clk;
    clk_wiz_0 clk_w(
        .clk_in1(clk_in),
        .clk_out1(clk),
        .reset(!rst_n)
        );
    wire op_ready;
    wire [3:0] opcode;
    wire [7:0] opnum1;
    wire [7:0] opnum2;
    wire dspa;
    wire next_line;
    wire overflow;
    wire clrs_wire;
    wire [7:0] key_code_wire;
    wire key_ready;
    wire test;
    assign test1=next_line;
    assign test2=rst_n;
    assign test3=clk;
    assign test4= key_ready;
    translate_line tl(
        .clk(clk),
        .rst(!rst_n),
        .PS2D(PS2D),
        .PS2C(PS2C),
        .op_ready(op_ready),
        .opcode(opcode),
        .opnum1(opnum1),
        .opnum2(opnum2),
        .next_line(next_line),
        .overflow(overflow),
        .key_code_out(key_code_wire),
        .key_ready(key_ready)
        );
    alu al(
        .rst_n(rst_n),
        .clk_out(clk),
        .ready(op_ready),
        .opcode(opcode),
        .opnum1(opnum1),
        .opnum2(opnum2),
        .a(ax),
        .b(bx),
        .c(cx),
        .d(dx),
        .cmprs(cmprs),
        .dspa(dspa),
        .clrs(clrs_wire)
        );

    // parameter [15:0] transtable[7:0]={
    //     8'h30,
    //     8'h31,
    //     8'h32,
    //     8'h33,
    //     8'h34,
    //     8'h35,
    //     8'h36,
    //     8'h37,
    //     8'h38,
    //     8'h39,
    //     8'h41,
    //     8'h42,
    //     8'h43,
    //     8'h44,
    //     8'h45,
    //     8'h46
    // };
    // parameter transtable_0 = 8'h30;
    // parameter transtable_1 = 8'h31;
    // parameter transtable_2 = 8'h32;
    // parameter transtable_3 = 8'h33;
    // parameter transtable_4 = 8'h34;
    // parameter transtable_5 = 8'h35;
    // parameter transtable_6 = 8'h36;
    // parameter transtable_7 = 8'h37;
    // parameter transtable_8 = 8'h38;
    // parameter transtable_9 = 8'h39;
    // parameter transtable_10 = 8'h41;
    // parameter transtable_11 = 8'h42;
    // parameter transtable_12 = 8'h43;
    // parameter transtable_13 = 8'h44;
    // parameter transtable_14 = 8'h45;
    // parameter transtable_15 = 8'h46;



    // reg [7:0] all_line[79:0];
    // always @(posedge clk or negedge rst_n) begin
    //     if(!rst_n) begin
    //         all_line[0] <= 80'h0;
    //         all_line[1] <= 80'h0;
    //         all_line[2] <= 80'h0;
    //         all_line[3] <= 80'h0;
    //         all_line[4] <= 80'h0;
    //         all_line[5] <= 80'h0;
    //         all_line[6] <= 80'h0;
    //         all_line[7] <= 80'h0;


    //     end else begin
    //         case(ax)
    //             4'b0000: all_line[0]<=transtable_0;
    //             4'b0001: all_line[0]<=transtable_1;
    //             4'b0010: all_line[0]<=transtable_2;
    //             4'b0011: all_line[0]<=transtable_3;
    //             4'b0100: all_line[0]<=transtable_4;
    //             4'b0101: all_line[0]<=transtable_5;
    //             4'b0110: all_line[0]<=transtable_6;
    //             4'b0111: all_line[0]<=transtable_7;
    //             4'b1000: all_line[0]<=transtable_8;
    //             4'b1001: all_line[0]<=transtable_9;
    //             4'b1010: all_line[0]<=transtable_10;
    //             4'b1011: all_line[0]<=transtable_11;
    //             4'b1100: all_line[0]<=transtable_12;
    //             4'b1101: all_line[0]<=transtable_13;
    //             4'b1110: all_line[0]<=transtable_14;
    //             4'b1111: all_line[0]<=transtable_15;
    //         endcase
    //         case(bx)
    //             4'b0000: all_line[2]<=transtable_0;
    //             4'b0001: all_line[2]<=transtable_1;
    //             4'b0010: all_line[2]<=transtable_2;
    //             4'b0011: all_line[2]<=transtable_3;
    //             4'b0100: all_line[2]<=transtable_4;
    //             4'b0101: all_line[2]<=transtable_5;
    //             4'b0110: all_line[2]<=transtable_6;
    //             4'b0111: all_line[2]<=transtable_7;
    //             4'b1000: all_line[2]<=transtable_8;
    //             4'b1001: all_line[2]<=transtable_9;
    //             4'b1010: all_line[2]<=transtable_10;
    //             4'b1011: all_line[2]<=transtable_11;
    //             4'b1100: all_line[2]<=transtable_12;
    //             4'b1101: all_line[2]<=transtable_13;
    //             4'b1110: all_line[2]<=transtable_14;
    //             4'b1111: all_line[2]<=transtable_15;
    //         endcase
    //         case(cx)
    //             4'b0000: all_line[4]<=transtable_0;
    //             4'b0001: all_line[4]<=transtable_1;
    //             4'b0010: all_line[4]<=transtable_2;
    //             4'b0011: all_line[4]<=transtable_3;
    //             4'b0100: all_line[4]<=transtable_4;
    //             4'b0101: all_line[4]<=transtable_5;
    //             4'b0110: all_line[4]<=transtable_6;
    //             4'b0111: all_line[4]<=transtable_7;
    //             4'b1000: all_line[4]<=transtable_8;
    //             4'b1001: all_line[4]<=transtable_9;
    //             4'b1010: all_line[4]<=transtable_10;
    //             4'b1011: all_line[4]<=transtable_11;
    //             4'b1100: all_line[4]<=transtable_12;
    //             4'b1101: all_line[4]<=transtable_13;
    //             4'b1110: all_line[4]<=transtable_14;
    //             4'b1111: all_line[4]<=transtable_15;
    //         endcase
    //         case(dx)
    //             4'b0000: all_line[6]<=transtable_0;
    //             4'b0001: all_line[6]<=transtable_1;
    //             4'b0010: all_line[6]<=transtable_2;
    //             4'b0011: all_line[6]<=transtable_3;
    //             4'b0100: all_line[6]<=transtable_4;
    //             4'b0101: all_line[6]<=transtable_5;
    //             4'b0110: all_line[6]<=transtable_6;
    //             4'b0111: all_line[6]<=transtable_7;
    //             4'b1000: all_line[6]<=transtable_8;
    //             4'b1001: all_line[6]<=transtable_9;
    //             4'b1010: all_line[6]<=transtable_10;
    //             4'b1011: all_line[6]<=transtable_11;
    //             4'b1100: all_line[6]<=transtable_12;
    //             4'b1101: all_line[6]<=transtable_13;
    //             4'b1110: all_line[6]<=transtable_14;
    //             4'b1111: all_line[6]<=transtable_15;
    //         endcase
    //         case(cmprs)
    //             1'b0: all_line[8]<=transtable_0;
    //             1'b1: all_line[8]<=transtable_1;
    //         endcase
            
    //     end
    // end

    // reg [7:0] write_data_in;
    // wire [7:0] write_data_in_wire;
    // assign write_data_in_wire = write_data_in;
    // reg wt_en_reg;
    // wire wt_en_wire;
    // assign wt_en_wire = wt_en_reg;
    // reg [7:0] all_line_ptr=0;
    screen_top st(
       .clk_out(clk),
       .rst_n(rst_n),
       .rst_scrn_bfr(clrs_wire),
       .wt_data_in(key_code_wire),
       .wt_en(key_ready),
       .clr_n(!clrs_wire),
       .next_line(next_line),
       .r(r),
       .g(g),
       .b(b),
       .hsync(hsync),
       .vsync(vsync)
    );

    // reg start_dspa;

    // always @(posedge clk) begin
    //     if(dspa) begin
    //         start_dspa <= 1;
    //     end else begin
    //         start_dspa <= 0;
    //     end
    // end
    // always @(posedge clk) begin 
    //     if(start_dspa) begin
    //         if(all_line_ptr < 80) begin
    //             if(!wt_en_reg) begin 
    //                 write_data_in <= all_line[all_line_ptr];
    //                 all_line_ptr <= all_line_ptr + 1;
    //                 wt_en_reg <= 1;
    //             end else begin
    //                 wt_en_reg <= 0;
    //             end
    //         end else begin
    //             start_dspa <= 0;
    //         end
    //     end else begin

    //         if(key_ready)begin
    //             wt_en_reg <= 1;
    //             write_data_in <= key_code_wire;
    //         end else begin
    //             wt_en_reg <= 0;
    //         end
    //     end

    // end

    
endmodule