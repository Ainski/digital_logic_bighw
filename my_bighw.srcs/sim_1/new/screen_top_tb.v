`timescale 1ps/1ps

module vga_top_tb;

    // �����ź�
    reg clk_out;
    reg rst_n;
    reg [7:0] wt_data_in;
    reg wt_en;

    // ����ź�
    wire [3:0] r;
    wire [3:0] g;
    wire [3:0] b;
    wire hsync;
    wire vsync;
    reg clr_n;
    reg rst_scrn_bfr;
    reg next_line;
    // ʵ����������ģ��
    screen_top uut (
        .clk_out(clk_out),
        .rst_n(rst_n),
        .wt_data_in(wt_data_in),
        .wt_en(wt_en),
        .r(r),
        .g(g),
        .b(b),
        .hsync(hsync),
        .vsync(vsync),
        .clr_n(clr_n),
        .rst_scrn_bfr(rst_scrn_bfr),
        .next_line(next_line)
    );

    // ʱ������
    initial begin
        clk_out = 0;
        forever #5 clk_out = ~clk_out; // 10ps���ڣ�50MHzʱ��
    end
    initial begin 
        rst_scrn_bfr=1;
        #20 
        rst_scrn_bfr=0;
    end
    // ���Թ���
    initial begin
        // ��ʼ���ź�
        rst_n = 0;
        wt_data_in = 8'h00;
        wt_en = 0;

        // ��λ
        #20;
        rst_n = 1;

        // �ȴ���λ���
        #20;
        
        // д���ַ�����
        wt_en = 1;
        wt_data_in = 8'h30; // д���ַ� '0'
        #10;
        wt_en = 0;
        #30720000 $finish;

    end
    initial begin
        clr_n=0;
        #10
        clr_n=1;
    end
    initial begin
        next_line=0;
        #10
        next_line=10;
        #10 
        next_line=0;
    end
    initial begin
        rst_scrn_bfr=1;
        #20 
        rst_scrn_bfr=0;
    end
    
    // �������ź�
//    initial begin
//        $monitor("Time: %0t | rst_n: %b | wt_en: %b | wt_data_in: %h | r: %h g: %h b: %h | hsync: %b vsync: %b", 
//                 $time, rst_n, wt_en, wt_data_in, r, g, b, hsync, vsync);
//    end

endmodule

