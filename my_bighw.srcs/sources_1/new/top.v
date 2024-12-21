module top(
    input wire clk,
    input wire rst_n,
    input wire PS2D,
    input wire PS2C,
    
    output [3:0] r,
    output [3:0] g,
    output [3:0] b,

    output hsync,
    output vsync
);

    wire op_ready;
    wire [7:0] opcode;
    wire [7:0] opnum1;
    wire [7:0] opnum2;
    wire [3:0] a;
    wire [3:0] b;
    wire [3:0] c;
    wire [3:0] d;
    wire cmprs;
    wire dspa;
    wire next_line;
    wire overflow;
    wire clrs_wire;
    wire [7:0] key_code_wire;
    wire key_ready;
    translate_line tl(
        .clk(clk),
        .rst_n(rst_n),
        .PS2D(PS2D),
        .PS2C(PS2C),
        .op_ready(op_ready),
        .opcode(opcode),
        .opnum1(opnum1),
        .opnum2(opnum2),
        .next_line(next_line),
        .overflow(overflow),
        .key_code(key_code_wire),
        .key_ready(key_ready)
        );
    alu al(
        .clk(clk),
        .rst_n(rst_n),
        .ready(op_ready),
        .opcode(opcode),
        .opnum1(opnum1),
        .opnum2(opnum2),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .cmprs(cmprs),
        .dspa(dspa),
        .clrs(clrs_wire)
        );

    parameter [7:0]transtable[15:0]={
        8'h30,
        8'h31,
        8'h32,
        8'h33,
        8'h34,
        8'h35,
        8'h36,
        8'h37,
        8'h38,
        8'h39,
        8'h41,
        8'h42,
        8'h43,
        8'h44,
        8'h45,
        8'h46
    };

    reg [7:0] all_line[80:0];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            all_line <= '{default:8'h20};
        end else begin
            all_line[0]<=transtable[a];
            all_line[2]<=transtable[b];
            all_line[4]<=transtable[c];
            all_line[6]<=transtable[d];
            all_line[8]<=transtable[dspa];
        end
    end

    reg [7:0] write_data_in;
    wire [7:0] write_data_in_wire;
    assign write_data_in_wire = write_data_in;
    reg wt_en_reg;
    wire wt_en_wire;
    assign wt_en_wire = wt_en_reg;
    reg [7:0] all_line_ptr=0;
//     `timescale 1ps/1ps
// module screen_top(
//     input wire clk_out,
//     input wire rst_n,
//     input wire rst_scrn_bfr,
//     input [7:0] wt_data_in,
//     input wt_en,
//     input wire clr_n,
//     input wire next_line,
//     output [3:0] r,
//     output [3:0] g,
//     output [3:0] b,

//     output hsync,
//     output vsync

// );
    screen_top st(
       .clk_out(clk),
       .rst_n(rst_n),
       .rst_scrn_bfr(clrs_wire),
       .wt_data_in(write_data_in_wire),
       .wt_en(wt_en_wire),
       .clr_n(clrs_wire),
       .next_line(next_line),
       .r(r),
       .g(g),
       .b(b),
       .hsync(hsync),
       .vsync(vsync)
    );

    reg start_dspa;

    alwayson @(posedge clk or negedge rst_n) begin
        if(dspa) begin
            start_dspa <= 1;
        end else begin
            start_dspa <= 0;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(start_dspa) begin
            if(all_line_ptr < 80) begin
                if(!wt_en_reg) begin 
                    write_data_in <= all_line[all_line_ptr];
                    all_line_ptr <= all_line_ptr + 1;
                    wt_en_reg <= 1;
                end else begin
                    wt_en_reg <= 0;
                end
            end else begin
                start_dspa <= 0;
            end
        end else begin

            if(key_ready)begin
                wt_en_reg <= 1;
                write_data_in <= key_code_wire;
            end else begin
                wt_en_reg <= 0;
            end
        end

    end

    
endmodule