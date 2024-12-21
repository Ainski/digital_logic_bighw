`timescale 1ps/1ps
module convert_to_vga (
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
    input [8:0] bg_rom_data
    );

    //把上面注释的字模数据加入到下面
    
    parameter [127:0] FONT_0 = 128'h0000386CC6C6D6D6C6C66C3800000000;       //0x30'0'
//parameter [127:0] FONT_0 = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;       //0x30'0'

    parameter [127:0] FONT_1 = 128'h00001838781818181818187E00000000;       //0x31'1'
    parameter [127:0] FONT_2 = 128'h00007CC6060C183060C0C6FE00000000;       //0x32'2'
    parameter [127:0] FONT_3 = 128'h00007CC606063C060606C67C00000000;       //0x33'3'
    parameter [127:0] FONT_4 = 128'h00000C1C3C6CCCFE0C0C0C1E00000000;       //0x34'4'
    parameter [127:0] FONT_5 = 128'h0000FEC0C0C0FC060606C67C00000000;       //0x35'5'
    parameter [127:0] FONT_6 = 128'h00003860C0C0FCC6C6C6C67C00000000;       //0x36'6'
    parameter [127:0] FONT_7 = 128'h0000FEC606060C183030303000000000;       //0x37'7'
    parameter [127:0] FONT_8 = 128'h00007CC6C6C67CC6C6C6C67C00000000;       //0x38'8'
    parameter [127:0] FONT_9 = 128'h00007CC6C6C67E0606060C7800000000;       //0x39'9'
    parameter [127:0] FONT_a = 128'h0000000000780C7CCCCCCC7600000000;       //0x61'a'
    parameter [127:0] FONT_b = 128'h0000E06060786C666666667C00000000;       //0x62'b'
    parameter [127:0] FONT_c = 128'h00000000007CC6C0C0C0C67C00000000;       //0x63'c'
    parameter [127:0] FONT_d = 128'h00001C0C0C3C6CCCCCCCCC7600000000;       //0x64'd'
    parameter [127:0] FONT_e = 128'h00000000007CC6FEC0C0C67C00000000;       //0x65'e'
    parameter [127:0] FONT_f = 128'h0000386C6460F060606060F000000000;       //0x66'f'
    parameter [127:0] FONT_g = 128'h000000000076CCCCCCCCCC7C0CCC7800;       //0x67'g'
    parameter [127:0] FONT_h = 128'h0000E060606C7666666666E600000000;       //0x68'h'
    parameter [127:0] FONT_i = 128'h00001818003818181818183C00000000;       //0x69'i'
    parameter [127:0] FONT_j = 128'h00000606000E06060606060666663C00;       //0x6A'j'
    parameter [127:0] FONT_k = 128'h0000E06060666C78786C66E600000000;       //0x6B'k'
    parameter [127:0] FONT_l = 128'h00003818181818181818183C00000000;       //0x6C'l'
    parameter [127:0] FONT_m = 128'h0000000000ECFED6D6D6D6C600000000;       //0x6D'm'
    parameter [127:0] FONT_n = 128'h0000000000DC66666666666600000000;       //0x6E'n'
    parameter [127:0] FONT_o = 128'h00000000007CC6C6C6C6C67C00000000;       //0x6F'o'
    parameter [127:0] FONT_p = 128'h0000000000DC66666666667C6060F000;       //0x70'p'
    parameter [127:0] FONT_q = 128'h000000000076CCCCCCCCCC7C0C0C1E00;       //0x71'q'
    parameter [127:0] FONT_r = 128'h0000000000DC7666606060F000000000;       //0x72'r'
    parameter [127:0] FONT_s = 128'h00000000007CC660380CC67C00000000;       //0x73's'
    parameter [127:0] FONT_t = 128'h0000103030FC30303030361C00000000;       //0x74't'
    parameter [127:0] FONT_u = 128'h0000000000CCCCCCCCCCCC7600000000;       //0x75'u'
    parameter [127:0] FONT_v = 128'h000000000066666666663C1800000000;       //0x76'v'
    parameter [127:0] FONT_w = 128'h0000000000C6C6D6D6D6FE6C00000000;       //0x77'w'
    parameter [127:0] FONT_x = 128'h0000000000C66C3838386CC600000000;       //0x78'x'
    parameter [127:0] FONT_y = 128'h0000000000C6C6C6C6C6C67E060CF800;       //0x79'y'
    parameter [127:0] FONT_z = 128'h0000000000FECC183060C6FE00000000;       //0x7A'z'
    parameter [127:0] FONT_A = 128'h000010386CC6C6FEC6C6C6C600000000;       //0x41'A'
    parameter [127:0] FONT_B = 128'h0000FC6666667C66666666FC00000000;       //0x42'B'
    parameter [127:0] FONT_C = 128'h00003C66C2C0C0C0C0C2663C00000000;       //0x43'C'
    parameter [127:0] FONT_D = 128'h0000F86C6666666666666CF800000000;       //0x44'D'
    parameter [127:0] FONT_E = 128'h0000FE6662687868606266FE00000000;       //0x45'E'
    parameter [127:0] FONT_F = 128'h0000FE6662687868606060F000000000;       //0x46'F'
    parameter [127:0] FONT_G = 128'h00003C66C2C0C0DEC6C6663A00000000;       //0x47'G'
    parameter [127:0] FONT_H = 128'h0000C6C6C6C6FEC6C6C6C6C600000000;       //0x48'H'
    parameter [127:0] FONT_I = 128'h00003C18181818181818183C00000000;       //0x49'I'
    parameter [127:0] FONT_J = 128'h00001E0C0C0C0C0CCCCCCC7800000000;       //0x4A'J'
    parameter [127:0] FONT_K = 128'h0000E666666C78786C6666E600000000;       //0x4B'K'
    parameter [127:0] FONT_L = 128'h0000F06060606060606266FE00000000;       //0x4C'L'
    parameter [127:0] FONT_M = 128'h0000C6EEFEFED6C6C6C6C6C600000000;       //0x4D'M'
    parameter [127:0] FONT_N = 128'h0000C6E6F6FEDECEC6C6C6C600000000;       //0x4E'N'
    parameter [127:0] FONT_O = 128'h00007CC6C6C6C6C6C6C6C67C00000000;       //0x4F'O'
    parameter [127:0] FONT_P = 128'h0000FC6666667C60606060F000000000;       //0x50'P'
    parameter [127:0] FONT_Q = 128'h00007CC6C6C6C6C6C6D6DE7C0C0E0000;       //0x51'Q'
    parameter [127:0] FONT_R = 128'h0000FC6666667C6C666666E600000000;       //0x52'R'
    parameter [127:0] FONT_S = 128'h00007CC6C660380C06C6C67C00000000;       //0x53'S'
    parameter [127:0] FONT_T = 128'h00007E7E5A1818181818183C00000000;       //0x54'T'
    parameter [127:0] FONT_U = 128'h0000C6C6C6C6C6C6C6C6C67C00000000;       //0x55'U'
    parameter [127:0] FONT_V = 128'h0000C6C6C6C6C6C6C66C381000000000;       //0x56'V'
    parameter [127:0] FONT_W = 128'h0000C6C6C6C6D6D6D6FEEE6C00000000;       //0x57'W'
    parameter [127:0] FONT_X = 128'h0000C6C66C7C38387C6CC6C600000000;       //0x58'X'
    parameter [127:0] FONT_Y = 128'h0000666666663C181818183C00000000;       //0x59'Y'
    parameter [127:0] FONT_Z = 128'h0000FEC6860C183060C2C6FE00000000;       //0x5A'Z'
    parameter [127:0] FONT_SPACE = 128'h00000000000000000000000000000000;       //0x20' '
    parameter [127:0] FONT_EXCLAMATION = 128'h0000183C3C3C18181800181800000000;       //0x21'!'
    parameter [127:0] FONT_TILDE = 128'h000076DC000000000000000000000000;       //0x7E'~'
    parameter [127:0] FONT_AT = 128'h0000007CC6C6DEDEDEDCC07C00000000;       //0x40'@'
    parameter [127:0] FONT_HASH = 128'h0000006C6CFE6C6C6CFE6C6C00000000;       //0x23'#'
    parameter [127:0] FONT_DOLLAR = 128'h18187CC6C2C07C060686C67C18180000;       //0x24'$'
    parameter [127:0] FONT_PERCENT = 128'h000000C2C60C183060C6860000000000;       //0x25'%'
    parameter [127:0] FONT_CARET = 128'h10386CC6000000000000000000000000;       //0x5E'^'
    parameter [127:0] FONT_AMPERSAND = 128'h0000386C6C3876DCCCCCCC7600000000;       //0x26'&'
    parameter [127:0] FONT_ASTERISK = 128'h00000010D63838D61000000000000000;       //0x2A'*'
    parameter [127:0] FONT_LPAREN = 128'h00000C18303030303030180C00000000;       //0x28'('
    parameter [127:0] FONT_RPAREN = 128'h000030180C0C0C0C0C0C183000000000;       //0x29')'
    parameter [127:0] FONT_UNDERSCORE = 128'h00000000000000000000000000FF0000;       //0x5F'_'
    parameter [127:0] FONT_PLUS = 128'h000000000018187E1818000000000000;       //0x2B'+'
    parameter [127:0] FONT_MINUS = 128'h00000000000000FE0000000000000000;       //0x2D'-'
    parameter [127:0] FONT_EQUAL = 128'h00000000007E00007E00000000000000;       //0x3D'='
    parameter [127:0] FONT_LBRACKET = 128'h00003C30303030303030303C00000000;       //0x5B'['
    parameter [127:0] FONT_RBRACKET = 128'h00003C0C0C0C0C0C0C0C0C3C00000000;       //0x5D']'
    parameter [127:0] FONT_BACKSLASH = 128'h000080C0E070381C0E06020000000000;       //0x5C'\'
    parameter [127:0] FONT_SEMICOLON = 128'h00000000181800000018180000000000;       //0x3B';'
    parameter [127:0] FONT_APOSTROPHE = 128'h00003030180000000000000000000000;       //0x60'`'
    parameter [127:0] FONT_COMMA = 128'h00000000000000000018181830000000;       //0x2C','
    parameter [127:0] FONT_PERIOD = 128'h00000000000000000000181800000000;       //0x2E'.'
    parameter [127:0] FONT_SLASH = 128'h0000000002060C183060C08000000000;       //0x2F'/'
    parameter [127:0] FONT_LBRACE = 128'h00000E18181870181818180E00000000;       //0x7B'{'
    parameter [127:0] FONT_RBRACE = 128'h0000701818180E181818187000000000;       //0x7D'}'
    parameter [127:0] FONT_PIPE = 128'h00001818181800181818181800000000;       //0x7C'|'
    parameter [127:0] FONT_COLON = 128'h00000000181800000018180000000000;       //0x3A':'
    parameter [127:0] FONT_QUOTE = 128'h00003030180000000000000000000000;       //0x60'`'
    parameter [127:0] FONT_LESS = 128'h000000060C18306030180C0600000000;       //0x3C'<'
    parameter [127:0] FONT_GREATER = 128'h0000006030180C060C18306000000000;       //0x3E'>'
    parameter [127:0] FONT_QUESTION = 128'h00007CC6C60C18181800181800000000;       //0x3F'?'


    reg start_rst=0;
    reg [9:0] bg_rom_addr_col_reg=0;
    reg [8:0] bg_rom_addr_row_reg=0;
    reg [8:0] bg_rom_data_reg=0;
    reg [127:0] font_data;
    assign bg_rom_addr = {bg_rom_addr_row_reg, bg_rom_addr_col_reg};
    assign bg_rom_data = bg_rom_data_reg;

    reg [9:0] vga_col_reg=0;
    reg [8:0] vga_row_reg=0;
    reg [8:0] vga_data_reg=0;
    reg vga_data_ena_reg=0;

    reg [3:0]letter_row=0;
    reg [2:0]letter_col=0;
    reg [8:0]letter_data_reg=0;
    reg letter_ena=0;
    assign wt_addr_vga_out = {vga_row_reg, vga_col_reg};
    assign wt_data_out = vga_data_reg;
    assign wt_en_vga = vga_data_ena_reg;


    always @ (posedge clk_out )begin
        if(rst_n == 0)begin
            if(~letter_ena&~start_rst)begin
                start_rst <= 1;
            end

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
     

    always @ (posedge clk_out )begin
        if(rst_n & wt_en&~start_rst)begin
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
        if(letter_ena)begin
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
                letter_row<=letter_row;
            end
            vga_data_reg <= letter_data_reg;
            vga_col_reg <= {scrn_bfr_col, letter_col};
            vga_row_reg <= {scrn_bfr_row, letter_row};
            vga_data_ena_reg <= 1;
            //根据上面被注释的字模，如果这一位为1，letter_data_reg 赋值为1ffh，否则赋值为00h
            if(font_data[{letter_row, letter_col}])begin
                letter_data_reg <= 9'b111111111;
            end else begin
                letter_data_reg <= 0;
            end
        end
    end
endmodule
