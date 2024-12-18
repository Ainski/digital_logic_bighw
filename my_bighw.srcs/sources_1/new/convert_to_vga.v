`timescale 1ps/1ps
module covert_to_vga (
    input clk_out,
    input rst_n,//also rom_data_ena

    input wt_en,
    input [6:0] scrn_bfr_col,
    input [4:0] scrn_bfr_row,
    input [7:0] wt_data_in,

    output wt_en_vga,
    output [18:0]wt_addr_vga_out,
    output [8:0]wt_data_out,

    output [18:0] bg_rom_addr,
    output bg_rom_addr_ena,
    input [8:0] bg_rom_data
    );

    //把上面注释的字模数据加入到下面
    
    parameter [127:0] FONT_0 = 128'h00000018244242424242424224180000;
    parameter [127:0] FONT_1 = 128'h000000083808080808080808083E0000;
    parameter [127:0] FONT_2 = 128'h0000003C4242420204081020427E0000;
    parameter [127:0] FONT_3 = 128'h0000003C4242020418040242423C0000;
    parameter [127:0] FONT_4 = 128'h000000040C0C142424447F04041F0000;
    parameter [127:0] FONT_5 = 128'h0000007E404040784402024244380000;
    parameter [127:0] FONT_6 = 128'h000000182440405C624242221C000000;
    parameter [127:0] FONT_7 = 128'h0000007E420404080810101010000000;
    parameter [127:0] FONT_8 = 128'h0000003C42422418244242423C000000;
    parameter [127:0] FONT_9 = 128'h00000038444242463A02022418000000;
    parameter [127:0] FONT_a = 128'h00000000000038440C34444C36000000;
    parameter [127:0] FONT_b = 128'h000000C0404058644242645800000000;
    parameter [127:0] FONT_c = 128'h00000000001C224040221C0000000000;
    parameter [127:0] FONT_d = 128'h0000000602023E4242463B0000000000;
    parameter [127:0] FONT_e = 128'h000000003C427E40423C000000000000;
    parameter [127:0] FONT_f = 128'h0000000C127C1010107C000000000000;
    parameter [127:0] FONT_g = 128'h0000003E4438403C42423C0000000000;
    parameter [127:0] FONT_h = 128'h000000C0405C624242E7000000000000;
    parameter [127:0] FONT_i = 128'h00003030701010107C00000000000000;
    parameter [127:0] FONT_j = 128'h00000C0C1C0404044478000000000000;
    parameter [127:0] FONT_k = 128'h0000C0404E4850704844EE0000000000;
    parameter [127:0] FONT_l = 128'h001070101010107C0000000000000000;
    parameter [127:0] FONT_m = 128'h000000FE49494949ED00000000000000;
    parameter [127:0] FONT_n = 128'h000000DC624242E70000000000000000;
    parameter [127:0] FONT_o = 128'h0000003C4242423C0000000000000000;
    parameter [127:0] FONT_p = 128'h000000D86442645840E0000000000000;
    parameter [127:0] FONT_q = 128'h0000001A2642261A0207000000000000;
    parameter [127:0] FONT_r = 128'h000000EE322020F80000000000000000;
    parameter [127:0] FONT_s = 128'h0000003E42403C027C00000000000000;
    parameter [127:0] FONT_t = 128'h0000107C1010120C0000000000000000;
    parameter [127:0] FONT_u = 128'h000000C642463B000000000000000000;
    parameter [127:0] FONT_v = 128'h000000EE442828101000000000000000;
    parameter [127:0] FONT_w = 128'h000000DB894A5A542424000000000000;
    parameter [127:0] FONT_x = 128'h00000076241818246E00000000000000;
    parameter [127:0] FONT_y = 128'h000000E7422418101060000000000000;
    parameter [127:0] FONT_z = 128'h0000007E440810227E00000000000000;
    parameter [127:0] FONT_A = 128'h0000101828243C4442E7000000000000;
    parameter [127:0] FONT_B = 128'h0000F8444478444244F8000000000000;
    parameter [127:0] FONT_C = 128'h00003E42808080443800000000000000;
    parameter [127:0] FONT_D = 128'h0000F844424244F80000000000000000;
    parameter [127:0] FONT_E = 128'h0000FC4248784842FC00000000000000;
    parameter [127:0] FONT_F = 128'h0000FC42487840E00000000000000000;
    parameter [127:0] FONT_G = 128'h00003C44808E44380000000000000000;
    parameter [127:0] FONT_H = 128'h0000E742427E42E70000000000000000;
    parameter [127:0] FONT_I = 128'h00007C1010107C000000000000000000;
    parameter [127:0] FONT_J = 128'h00003E0808080888F000000000000000;
    parameter [127:0] FONT_K = 128'h0000EE444850704844EE000000000000;
    parameter [127:0] FONT_L = 128'h0000E0404042FE000000000000000000;
    parameter [127:0] FONT_M = 128'h0000EE6C6C5454D60000000000000000;
    parameter [127:0] FONT_N = 128'h0000C762524A4AE20000000000000000;
    parameter [127:0] FONT_O = 128'h00003844828244380000000000000000;
    parameter [127:0] FONT_P = 128'h0000FC427C40E0000000000000000000;
    parameter [127:0] FONT_Q = 128'h0000384482B24C380600000000000000;
    parameter [127:0] FONT_R = 128'h0000FC427C4844E30000000000000000;
    parameter [127:0] FONT_S = 128'h00003E424020047C0000000000000000;
    parameter [127:0] FONT_T = 128'h0000FE92101038000000000000000000;
    parameter [127:0] FONT_U = 128'h0000E74242423C000000000000000000;
    parameter [127:0] FONT_V = 128'h0000E742242818100000000000000000;
    parameter [127:0] FONT_W = 128'h0000D654546C28280000000000000000;
    parameter [127:0] FONT_X = 128'h0000E724182442E70000000000000000;
    parameter [127:0] FONT_Y = 128'h0000EE28101038000000000000000000;
    parameter [127:0] FONT_Z = 128'h00007E04081042FC0000000000000000;
    parameter [127:0] FONT_SPACE = 128'h00000000000000000000000000000000;
    parameter [127:0] FONT_EXCLAMATION = 128'h00001010101010100010100000000000;
    parameter [127:0] FONT_TILDE = 128'h205A0400000000000000000000000000;
    parameter [127:0] FONT_AT = 128'h0038445AAAAA5C423C00000000000000;
    parameter [127:0] FONT_HASH = 128'h00127E247E2424000000000000000000;
    parameter [127:0] FONT_DOLLAR = 128'h083C4A48380C0A4A3C08080000000000;
    parameter [127:0] FONT_PERCENT = 128'h44A4A8B0541A2A4A4400000000000000;
    parameter [127:0] FONT_CARET = 128'h18240000000000000000000000000000;
    parameter [127:0] FONT_AMPERSAND = 128'h304848506EA494897600000000000000;
    parameter [127:0] FONT_ASTERISK = 128'h0010D63838D610000000000000000000;
    parameter [127:0] FONT_LPAREN = 128'h02040810101008080402000000000000;
    parameter [127:0] FONT_RPAREN = 128'h40201008080810102040000000000000;
    parameter [127:0] FONT_UNDERSCORE = 128'h000000000000000000000000000000FF;
    parameter [127:0] FONT_PLUS = 128'h000008087F0808000000000000000000;
    parameter [127:0] FONT_MINUS = 128'h000000007E0000000000000000000000;
    parameter [127:0] FONT_EQUAL = 128'h0000007E007E00000000000000000000;
    parameter [127:0] FONT_LBRACKET = 128'h1E1010101010101E0000000000000000;
    parameter [127:0] FONT_RBRACKET = 128'h78080808080808780000000000000000;
    parameter [127:0] FONT_BACKSLASH = 128'h40202010100808040402020000000000;
    parameter [127:0] FONT_SEMICOLON = 128'h00000010000010100000000000000000;
    parameter [127:0] FONT_APOSTROPHE = 128'h60204000000000000000000000000000;
    parameter [127:0] FONT_COMMA = 128'h00000000006020204000000000000000;
    parameter [127:0] FONT_PERIOD = 128'h00000000606000000000000000000000;
    parameter [127:0] FONT_SLASH = 128'h02040408101020204000000000000000;
    parameter [127:0] FONT_LBRACE = 128'h03040404040804040300000000000000;
    parameter [127:0] FONT_RBRACE = 128'hC020202020102020C000000000000000;
    parameter [127:0] FONT_PIPE = 128'h08080808080808080808080808080808;
    parameter [127:0] FONT_COLON = 128'h00001818000018180000000000000000;
    parameter [127:0] FONT_QUOTE = 128'h12244800000000000000000000000000;
    parameter [127:0] FONT_LESS = 128'h02040810201008040200000000000000;
    parameter [127:0] FONT_GREATER = 128'h40201008040204081020400000000000;
    parameter [127:0] FONT_QUESTION = 128'h3C426204080800181800000000000000;


    reg start_rst=0;
    reg [9:0] bg_rom_addr_col_reg=0;
    reg [8:0] bg_rom_addr_row_reg=0;
    reg [8:0] bg_rom_data_reg=0;
    reg bg_rom_addr_ena_reg=0;
    reg [127:0] font_data;
    assign bg_rom_addr = {bg_rom_addr_row_reg, bg_rom_addr_col_reg};
    assign bg_rom_addr_ena = bg_rom_addr_ena_reg;
    assign bg_rom_data = bg_rom_data_reg;

    reg [9:0] vga_col_reg=0;
    reg [8:0] vga_row_reg=0;
    reg [8:0] vga_data_reg=0;
    reg vga_data_ena_reg=0;


    assign wt_addr_vga_out = {vga_row_reg, vga_col_reg};
    assign wt_data_out = vga_data_reg;
    assign wt_en_vga = vga_data_ena_reg;


    always @ (posedge clk_out )begin
        if(rst_n == 0)begin
            start_rst <= 1;
            bg_rom_addr_ena_reg <= 1;

            bg_rom_addr_row_reg <= 0;
            bg_rom_addr_col_reg <= 0;
            bg_rom_data_reg <= 0;

            vga_data_reg <= 0;
            vga_data_ena_reg <= 0;
            vga_col_reg <= 0;
            vga_row_reg <= 0;

        end
    end

    always @ (posedge clk_out )begin
        if(start_rst == 1)begin
            if(bg_rom_addr_col_reg==639)begin
                if(bg_rom_addr_row_reg==479)begin
                    bg_rom_addr_row_reg <= 0;
                    bg_rom_addr_col_reg <= 0;
                    vga_data_ena_reg <= 0;
                    start_rst <= 0;
                    bg_rom_addr_ena_reg <= 0;
                end else begin
                    bg_rom_addr_row_reg <= bg_rom_addr_row_reg + 1;
                    bg_rom_addr_col_reg <= 0;
                end
            end else begin
                bg_rom_addr_col_reg <= bg_rom_addr_col_reg + 1;
            end
            vga_data_reg <= bg_rom_data;
            vga_data_ena_reg <= 1;
            vga_col_reg <= bg_rom_addr_col_reg;
            vga_row_reg <= bg_rom_addr_row_reg;

        end
    end
     
    reg [3:0]letter_row=0;
    reg [2:0]letter_col=0;
    reg [8:0]letter_data_reg=0;
    reg letter_ena=0;
    always @ (posedge clk_out )begin
        if(rst_n && wt_en)begin
            letter_ena <= 1;
            vga_data_ena_reg <= 1;
        end
    end

    reg [127:0]ascii_code;
    always @(*)begin
        case(wt_data_in)
            8'h30: font_data = FONT_0;
            8'h31: font_data = FONT_1;
            8'h32: font_data = FONT_2;
            8'h33: font_data = FONT_3;
            8'h34: font_data = FONT_4;
            8'h35: font_data = FONT_5;
            8'h36: font_data = FONT_6;
            8'h37: font_data = FONT_7;
            8'h38: font_data = FONT_8;
            8'h39: font_data = FONT_9;
            8'h61: font_data = FONT_a;
            8'h62: font_data = FONT_b;
            8'h63: font_data = FONT_c;
            8'h64: font_data = FONT_d;
            8'h65: font_data = FONT_e;
            8'h66: font_data = FONT_f;
            8'h67: font_data = FONT_g;
            8'h68: font_data = FONT_h;
            8'h69: font_data = FONT_i;
            8'h6A: font_data = FONT_j;
            8'h6B: font_data = FONT_k;
            8'h6C: font_data = FONT_l;
            8'h6D: font_data = FONT_m;
            8'h6E: font_data = FONT_n;
            8'h6F: font_data = FONT_o;
            8'h70: font_data = FONT_p;
            8'h71: font_data = FONT_q;
            8'h72: font_data = FONT_r;
            8'h73: font_data = FONT_s;
            8'h74: font_data = FONT_t;
            8'h75: font_data = FONT_u;
            8'h76: font_data = FONT_v;
            8'h77: font_data = FONT_w;
            8'h78: font_data = FONT_x;
            8'h79: font_data = FONT_y;
            8'h7A: font_data = FONT_z;
            8'h41: font_data = FONT_A;
            8'h42: font_data = FONT_B;
            8'h43: font_data = FONT_C;
            8'h44: font_data = FONT_D;
            8'h45: font_data = FONT_E;
            8'h46: font_data = FONT_F;
            8'h47: font_data = FONT_G;
            8'h48: font_data = FONT_H;
            8'h49: font_data = FONT_I;
            8'h4A: font_data = FONT_J;
            8'h4B: font_data = FONT_K;
            8'h4C: font_data = FONT_L;
            8'h4D: font_data = FONT_M;
            8'h4E: font_data = FONT_N;
            8'h4F: font_data = FONT_O;
            8'h50: font_data = FONT_P;
            8'h51: font_data = FONT_Q;
            8'h52: font_data = FONT_R;
            8'h53: font_data = FONT_S;
            8'h54: font_data = FONT_T;
            8'h55: font_data = FONT_U;
            8'h56: font_data = FONT_V;
            8'h57: font_data = FONT_W;
            8'h58: font_data = FONT_X;
            8'h59: font_data = FONT_Y;
            8'h5A: font_data = FONT_Z;
            8'h20: font_data = FONT_SPACE;
            8'h21: font_data = FONT_EXCLAMATION;
            8'h7E: font_data = FONT_TILDE;
            8'h40: font_data = FONT_AT;
            8'h23: font_data = FONT_HASH;
            8'h24: font_data = FONT_DOLLAR;
            8'h25: font_data = FONT_PERCENT;
            8'h5E: font_data = FONT_CARET;
            8'h26: font_data = FONT_AMPERSAND;
            8'h2A: font_data = FONT_ASTERISK;
            8'h28: font_data = FONT_LPAREN;
            8'h29: font_data = FONT_RPAREN;
            8'h5F: font_data = FONT_UNDERSCORE;
            8'h2B: font_data = FONT_PLUS;
            8'h2D: font_data = FONT_MINUS;
            8'h3D: font_data = FONT_EQUAL;
            8'h5B: font_data = FONT_LBRACKET;
            8'h5D: font_data = FONT_RBRACKET;
            8'h5C: font_data = FONT_BACKSLASH;
            8'h3B: font_data = FONT_SEMICOLON;
            8'h27: font_data = FONT_APOSTROPHE;
            8'h2C: font_data = FONT_COMMA;
            8'h2E: font_data = FONT_PERIOD;
            8'h2F: font_data = FONT_SLASH;
            8'h7B: font_data = FONT_LBRACE;
            8'h7D: font_data = FONT_RBRACE;
            8'h7C: font_data = FONT_PIPE;
            8'h3A: font_data = FONT_COLON;
            8'h22: font_data = FONT_QUOTE;
            8'h3C: font_data = FONT_LESS;
            8'h3E: font_data = FONT_GREATER;
            8'h3F: font_data = FONT_QUESTION;
            default: font_data = FONT_SPACE;
        endcase
    end
    always @ (posedge clk_out )begin
        if(rst_n && wt_en && letter_ena)begin
            if(letter_col==7)begin
                if(letter_row==15)begin
                    letter_row <= 0;
                    letter_col <= 0;
                    letter_ena <= 0;
                    vga_data_ena_reg <= 0;

                end else begin
                    letter_row <= letter_row + 1;
                    letter_col <= 0;
                end
            end else begin
                letter_col <= letter_col + 1;
            end
            vga_data_reg <= letter_data_reg;
            vga_col_reg <= {scrn_bfr_col, letter_col};
            vga_row_reg <= {scrn_bfr_row, letter_row};
            vga_data_ena_reg <= 1;
            //根据上面被注释的字模，如果这一位为1，letter_data_reg 赋值为1ffh，否则赋值为00h
            if(font_data[{letter_row, letter_col}])begin
                letter_data_reg <= 255;
            end else begin
                letter_data_reg <= 0;
            end
        end
    end
endmodule
