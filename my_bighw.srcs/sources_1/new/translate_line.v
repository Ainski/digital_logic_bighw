`timescale 1ps/1ps
module translate_line(
    input           clk,
    input           rst,
    input           PS2D,
    input           PS2C,
    output  reg [3:0]  opcode,
    output  reg [7:0]  opnum1,
    output  reg [7:0]  opnum2,
    output op_ready,
    output reg next_line,
    output reg overflow,
    output [7:0] key_code_out ,
    output reg key_ready
);

parameter [23:0] lod_name = 24'h444F4C;  // 'D' 'O' 'L'
parameter [23:0] mov_name = 24'h564F4D;  // 'V' 'O' 'M'
parameter [23:0] add_name = 24'h444441;  // 'D' 'D' 'A'
parameter [23:0] sub_name = 24'h425553;  // 'B' 'U' 'S'
parameter [23:0] xor_name = 24'h524F58;  // 'R' 'O' 'X'
parameter [23:0] oor_name = 24'h524F4F;  // 'R' 'O' 'O'
parameter [23:0] and_name = 24'h444E41;  // 'D' 'N' 'A'
parameter [23:0] sll_name = 24'h4C4C53;  // 'L' 'L' 'S'
parameter [23:0] srl_name = 24'h4C5253;  // 'L' 'R' 'S'
parameter [23:0] clr_name = 24'h524C43;  // 'R' 'L' 'C'
parameter [23:0] rst_name = 24'h545352;  // 'T' 'S' 'R'
parameter [23:0] dsa_name = 24'h415344;  // 'A' 'S' 'D'
parameter [23:0] equ_name = 24'h555145;  // 'U' 'Q' 'E'
parameter [23:0] big_name = 24'h474942;  // 'G' 'I' 'B'
parameter [23:0] lit_name = 24'h54494C;  // 'T' 'I' 'L'

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


    reg [639:0] line_buffer;
    reg [7:0] line_buffer_ptr;
    reg enter=0;
    wire [7:0]key_code;
    assign key_code_out = key_code;
    wire ready;
    always@(posedge clk)begin
        key_ready=ready;
    end 

    reg opcode_ready;
    reg opnum1_ready;
    reg opnum2_ready;

    assign op_ready = opcode_ready && opnum1_ready && opnum2_ready;
    key_translate kt(
        .clk(clk),
        .PS2D(PS2D),
        .PS2C(PS2C),
        .key_code(key_code),
        .rst(rst),
        .ready_wire(ready)
    );

    always@( posedge clk)
    begin
        if( rst )
        begin
            line_buffer_ptr <= 0;
            line_buffer <= 0;
            opcode <= 0;
            opnum1 <= 0;
            opnum2 <= 0;
            opcode_ready <= 0;
            enter<=0;
            next_line <= 0;
            overflow <= 0;
            key_ready<=0;
        end
        else begin
            if( ready )begin
                if( key_code == 8'h0d ) begin

                    opcode <= 0;
                    opnum1 <= 0;
                    opnum2 <= 0;
                    next_line <=1;
                    overflow <= 0;
                    enter<=1;
                end
                else begin
                    //line_buffer[{line_buffer_ptr, 7}:{line_buffer_ptr, 0}]<= key_code;
                    line_buffer[line_buffer_ptr+0]<= key_code[0];
                    line_buffer[line_buffer_ptr+1]<= key_code[1];
                    line_buffer[line_buffer_ptr+2]<= key_code[2];
                    line_buffer[line_buffer_ptr+3]<= key_code[3];
                    line_buffer[line_buffer_ptr+4]<= key_code[4];
                    line_buffer[line_buffer_ptr+5]<= key_code[5];
                    line_buffer[line_buffer_ptr+6]<= key_code[6];
                    line_buffer[line_buffer_ptr+7]<= key_code[7];

                    
                    line_buffer_ptr <= line_buffer_ptr + 8;
                end
                if( line_buffer_ptr == 640 ) begin
                    line_buffer_ptr <= 0;
                    line_buffer <= 0;
                    opcode <= 0;
                    opnum1 <= 0;
                    opnum2 <= 0;
                    opcode_ready <= 0;
                    next_line <= 1;
                    overflow <= 1;
                    enter<=0;
                end else begin
                    next_line <= 0;
                    overflow <= 0;
                    enter<=0;
                end
            end
        end
    end

    always @(posedge enter) begin
        line_buffer_ptr <= 0;
        line_buffer <= 0;
        case(line_buffer[23:0])
            lod_name: begin
                opcode <= lod_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h30: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h31: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h32: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h33: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    8'h34: begin
                        opnum2<= 8'h04;
                        opnum2_ready <= 1;
                    end
                    8'h35: begin
                        opnum2<= 8'h05;
                        opnum2_ready <= 1;
                    end
                    8'h36: begin
                        opnum2<= 8'h06;
                        opnum2_ready <= 1;
                    end
                    8'h37: begin
                        opnum2<= 8'h07;
                        opnum2_ready <= 1;
                    end
                    8'h38: begin
                        opnum2<= 8'h08;
                        opnum2_ready <= 1;
                    end
                    8'h39: begin
                        opnum2<= 8'h09;
                        opnum2_ready <= 1;
                    end
                    8'h41: begin
                        opnum2<= 8'h0a;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h0b;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h0c;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h0d;
                        opnum2_ready <= 1;
                    end
                    8'h45: begin
                        opnum2<= 8'h0e;
                        opnum2_ready <= 1;
                    end
                    8'h46: begin
                        opnum2<= 8'h0f;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            mov_name: begin
                opcode <= mov_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            add_name: begin
                opcode <= add_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            sub_name: begin
                opcode <= sub_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            xor_name: begin
                opcode <= xor_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            oor_name: begin
                opcode <= oor_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            and_name: begin
                opcode <= and_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            sll_name: begin
                opcode <= sll_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            srl_name: begin
                opcode <= srl_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])  
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end

            clr_name: begin
                opcode <= clr_code;
                opcode_ready <= 1;
                opnum1_ready <= 1;
                opnum2_ready <= 1;
            end
            rst_name: begin
                opcode <= rst_code;
                opcode_ready <= 1;
                opnum1_ready <= 1;
                opnum2_ready <= 1;
            end
            dsa_name: begin
                opcode <= dsa_code;
                opcode_ready <= 1;
                opnum1_ready <= 1;
                opnum2_ready <= 1;
            end
            equ_name: begin
                opcode <= equ_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            big_name: begin
                opcode <= big_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            lit_name: begin
                opcode <= lit_code;
                opcode_ready <= 1;
                case (line_buffer[39:32])
                    8'h41: begin
                        opnum1<= 8'h00;
                        opnum1_ready <= 1;
                    end
                    8'h42: begin
                        opnum1<= 8'h01;
                        opnum1_ready <= 1;
                    end
                    8'h43: begin
                        opnum1<= 8'h02;
                        opnum1_ready <= 1;
                    end
                    8'h44: begin
                        opnum1<= 8'h03;
                        opnum1_ready <= 1;
                    end
                    default: opnum1_ready <= 0;
                endcase
                case (line_buffer[55:48])
                    8'h41: begin
                        opnum2<= 8'h00;
                        opnum2_ready <= 1;
                    end
                    8'h42: begin
                        opnum2<= 8'h01;
                        opnum2_ready <= 1;
                    end
                    8'h43: begin
                        opnum2<= 8'h02;
                        opnum2_ready <= 1;
                    end
                    8'h44: begin
                        opnum2<= 8'h03;
                        opnum2_ready <= 1;
                    end
                    default: opnum2_ready <= 0;
                endcase
            end
            default: opcode <= 0;
        endcase

    end

endmodule
