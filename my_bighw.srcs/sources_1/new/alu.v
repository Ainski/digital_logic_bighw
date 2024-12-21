`timescale 1ps/1ps
module alu(
    input wire clk_out,
    input wire [7:0] opcode,
    input wire [7:0] opnum1,
    input wire [7:0] opnum2,
    input wire ready,
    output reg [3:0] a,
    output reg [3:0] b,
    output reg [3:0] c,
    output reg [3:0] d,
    output reg cmprs,
    output reg dspa,
    output reg clrs

);

    parameter [3:0] lod_code = 4'b0001;
    parameter [3:0] mov_code = 4'b0010;
    parameter [3:0] add_code = 4'b0011;
    parameter [3:0] sub_code = 4'b0100;
    parameter [3:0] xor_code = 4'b0101;
    parameter [3:0] oor_code = 4'b0110;
    parameter [3:0] and_code = 4'b0111;
    parameter [3:0] sll_code = 4'b1000;
    parameter [3:0] srl_code = 4'b1001;
    parameter [3:0] clr_code = 4'b1010;
    parameter [3:0] rst_code = 4'b1011;
    parameter [3:0] dsa_code = 4'b1100;
    parameter [3:0] equ_code = 4'b1101;
    parameter [3:0] big_code = 4'b1110;
    parameter [3:0] lit_code = 4'b1111;
    always @(posedge clk_out )
    begin
        if (ready) begin
            case (opcode)
                lod_code: begin
                    case (opnum1)
                        8'h00: a <= opnum2[3:0];
                        8'h01: b <= opnum2[3:0];
                        8'h02: c <= opnum2[3:0];
                        8'h03: d <= opnum2[3:0];
                    endcase
                    dspa<=0;
                    clrs<=0;
                end
                mov_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a;
                                8'h01: a <= b;
                                8'h02: a <= c;
                                8'h03: a <= d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= a;
                                8'h01: b <= b;
                                8'h02: b <= c;
                                8'h03: b <= d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= a;
                                8'h01: c <= b;
                                8'h02: c <= c;
                                8'h03: c <= d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= a;
                                8'h01: d <= b;
                                8'h02: d <= c;
                                8'h03: d <= d;
                            endcase
                        end
                    endcase
                end
                add_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a + a;
                                8'h01: a <= a + b;
                                8'h02: a <= a + c;
                                8'h03: a <= a + d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b + a;
                                8'h01: b <= b + b;
                                8'h02: b <= b + c;
                                8'h03: b <= b + d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c + a;
                                8'h01: c <= c + b;
                                8'h02: c <= c + c;
                                8'h03: c <= c + d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d + a;
                                8'h01: d <= d + b;
                                8'h02: d <= d + c;
                                8'h03: d <= d + d;
                            endcase
                        end
                    endcase
                end
                sub_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a - a;
                                8'h01: a <= a - b;
                                8'h02: a <= a - c;
                                8'h03: a <= a - d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b - a;
                                8'h01: b <= b - b;
                                8'h02: b <= b - c;
                                8'h03: b <= b - d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c - a;
                                8'h01: c <= c - b;
                                8'h02: c <= c - c;
                                8'h03: c <= c - d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d - a;
                                8'h01: d <= d - b;
                                8'h02: d <= d - c;
                                8'h03: d <= d - d;
                            endcase
                        end
                    endcase
                end
                xor_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a ^ a;
                                8'h01: a <= a ^ b;
                                8'h02: a <= a ^ c;
                                8'h03: a <= a ^ d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b ^ a;
                                8'h01: b <= b ^ b;
                                8'h02: b <= b ^ c;
                                8'h03: b <= b ^ d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c ^ a;
                                8'h01: c <= c ^ b;
                                8'h02: c <= c ^ c;
                                8'h03: c <= c ^ d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d ^ a;
                                8'h01: d <= d ^ b;
                                8'h02: d <= d ^ c;
                                8'h03: d <= d ^ d;
                            endcase
                        end
                    endcase
                end
                oor_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a | a;
                                8'h01: a <= a | b;
                                8'h02: a <= a | c;
                                8'h03: a <= a | d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b | a;
                                8'h01: b <= b | b;
                                8'h02: b <= b | c;
                                8'h03: b <= b | d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c | a;
                                8'h01: c <= c | b;
                                8'h02: c <= c | c;
                                8'h03: c <= c | d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d | a;
                                8'h01: d <= d | b;
                                8'h02: d <= d | c;
                                8'h03: d <= d | d;
                            endcase
                        end
                       endcase
                end
                and_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a & a;
                                8'h01: a <= a & b;
                                8'h02: a <= a & c;
                                8'h03: a <= a & d;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b & a;
                                8'h01: b <= b & b;
                                8'h02: b <= b & c;
                                8'h03: b <= b & d;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c & a;
                                8'h01: c <= c & b;
                                8'h02: c <= c & c;
                                8'h03: c <= c & d;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d & a;
                                8'h01: d <= d & b;
                                8'h02: d <= d & c;
                                8'h03: d <= d & d;
                            endcase
                        end
                    endcase
                end
                sll_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a << 1;
                                8'h01: a <= a << 2;
                                8'h02: a <= a << 3;
                                8'h03: a <= a << 4;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b << 1;
                                8'h01: b <= b << 2;
                                8'h02: b <= b << 3;
                                8'h03: b <= b << 4;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c << 1;
                                8'h01: c <= c << 2;
                                8'h02: c <= c << 3;
                                8'h03: c <= c << 4;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d << 1;
                                8'h01: d <= d << 2;
                                8'h02: d <= d << 3;
                                8'h03: d <= d << 4;
                            endcase
                        end
                    endcase
                end
                srl_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: a <= a >> 1;
                                8'h01: a <= a >> 2;
                                8'h02: a <= a >> 3;
                                8'h03: a <= a >> 4;
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: b <= b >> 1;
                                8'h01: b <= b >> 2;
                                8'h02: b <= b >> 3;
                                8'h03: b <= b >> 4;
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: c <= c >> 1;
                                8'h01: c <= c >> 2;
                                8'h02: c <= c >> 3;
                                8'h03: c <= c >> 4;
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: d <= d >> 1;
                                8'h01: d <= d >> 2;
                                8'h02: d <= d >> 3;
                                8'h03: d <= d >> 4;
                            endcase
                        end
                    endcase
                end
                clr_code: begin
                    a<= 4'b0000;
                    b<= 4'b0000;
                    c<= 4'b0000;
                    d<= 4'b0000;
                    clrs<=1;
                end
                rst_code: begin
                    a<= 4'b0000;
                    b<= 4'b0000;
                    c<= 4'b0000;
                    d<= 4'b0000;
                end
                dsa_code: begin
                    dspa<=1;
                    clrs<=0;
                end
                equ_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: cmprs <= (a == a);
                                8'h01: cmprs <= (a == b);
                                8'h02: cmprs <= (a == c);
                                8'h03: cmprs <= (a == d);
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: cmprs <= (b == a);
                                8'h01: cmprs <= (b == b);
                                8'h02: cmprs <= (b == c);
                                8'h03: cmprs <= (b == d);
                            endcase 
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: cmprs <= (c == a);
                                8'h01: cmprs <= (c == b);
                                8'h02: cmprs <= (c == c);
                                8'h03: cmprs <= (c == d);
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: cmprs <= (d == a);
                                8'h01: cmprs <= (d == b);
                                8'h02: cmprs <= (d == c);
                                8'h03: cmprs <= (d == d);
                            endcase
                        end
                    endcase
                end
                big_code: begin
                    clrs<=0;
                    dspa<=0;

                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: cmprs <= (a > a);
                                8'h01: cmprs <= (a > b);
                                8'h02: cmprs <= (a > c);
                                8'h03: cmprs <= (a > d);
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: cmprs <= (b > a);
                                8'h01: cmprs <= (b > b);
                                8'h02: cmprs <= (b > c);
                                8'h03: cmprs <= (b > d);
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: cmprs <= (c > a);
                                8'h01: cmprs <= (c > b);
                                8'h02: cmprs <= (c > c);
                                8'h03: cmprs <= (c > d);
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: cmprs <= (d > a);
                                8'h01: cmprs <= (d > b);
                                8'h02: cmprs <= (d > c);
                                8'h03: cmprs <= (d > d);
                            endcase
                        end
                    endcase
                end
                lit_code: begin
                    dspa<=0;
                    clrs<=0;
                    case (opnum1)
                        8'h00: begin
                            case (opnum2)
                                8'h00: cmprs <= (a < a);
                                8'h01: cmprs <= (a < b);
                                8'h02: cmprs <= (a < c);
                                8'h03: cmprs <= (a < d);
                            endcase
                        end
                        8'h01: begin
                            case (opnum2)
                                8'h00: cmprs <= (b < a);
                                8'h01: cmprs <= (b < b);
                                8'h02: cmprs <= (b < c);
                                8'h03: cmprs <= (b < d);
                            endcase
                        end
                        8'h02: begin
                            case (opnum2)
                                8'h00: cmprs <= (c < a);
                                8'h01: cmprs <= (c < b);
                                8'h02: cmprs <= (c < c);
                                8'h03: cmprs <= (c < d);
                            endcase
                        end
                        8'h03: begin
                            case (opnum2)
                                8'h00: cmprs <= (d < a);
                                8'h01: cmprs <= (d < b);
                                8'h02: cmprs <= (d < c);
                                8'h03: cmprs <= (d < d);
                            endcase
                        end
                    endcase
                end
            endcase
        end else begin
            dspa<=0;
            clrs<=0;

        end
    end

endmodule
