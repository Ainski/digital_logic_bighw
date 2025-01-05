`timescale 1ps / 1ps
module translate_line_tb;

    reg clk;
    reg rst;
    reg ps2d;
    reg ps2c;
    wire [3:0]opcode;
    wire [7:0]opnum1;
    wire [7:0]opnum2;
    wire op_ready;
    wire next_line;
    wire overflow;
    wire [7:0]key_code_out;
    wire key_ready;


    translate_line dut (
       .clk(clk),
       .rst(rst),
       .PS2D(ps2d),
       .PS2C(ps2c),
       .opcode(opcode),
       .opnum1(opnum1),
       .opnum2(opnum2),
       .op_ready(op_ready),
       .next_line(next_line),
       .overflow(overflow),
       .key_code_out(key_code_out),
       .key_ready(key_ready)
    );

    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        rst = 1;
        ps2d = 0;
        ps2c = 0;
        #100 rst = 0;
    end

    initial begin
        #100
        ps2c =1;
        forever #100 ps2c = ~ps2c;
    end

    initial begin
        #2000//mov 键码
        //3a 'm'
        ps2d=0;//begin

        #200 ps2d = 0 ;
        #200 ps2d = 1 ;
        #200 ps2d = 0 ;
        #200 ps2d = 1;
        #200 ps2d=1;
        #200 ps2d=1;
        #200 ps2d=0;
        #200 ps2d=0;//content

        #200 ps2d=0;//奇偶校验�????
        #200 ps2d=1;//end

        //f0
        #1000 ps2d =0 ;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1 ;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0 ;
        #200 ps2d = 1 ;

        //3a
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //31 'o'
        #2000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0;
        #200 ps2d = 1;


        //31
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //2A 'v'
        #2000 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;


        #200 ps2d = 0;
        #200 ps2d = 1;

        //2A
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        
        #200 ps2d = 1;
        #200 ps2d = 1;

        //' '
        //29
        #2000 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000
        ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //29
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;


        //'a'
        //1c
        #2000 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //1c
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //' '
        //29
        #2000 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //29
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //'b'
        //32
        #2000 ps2d = 0;

        #200 ps2d = 0; 
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //32
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 0;

        #200 ps2d = 1;
        #200 ps2d = 1;

        // //' '
        // //29
        // #2000 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 1;

        // //f0
        // #1000 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 1;
        // #200 ps2d = 1;
        // #200 ps2d = 1;

        // #200 ps2d = 0;
        // #200 ps2d = 1;

        // //29
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 1;
        // #200 ps2d = 0;
        // #200 ps2d = 0;

        // #200 ps2d = 1;
        // #200 ps2d = 1;

        //'\n'
        //5A 
        #2000 ps2d =0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1 ;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //f0
        #1000 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 1;

        #200 ps2d = 0;
        #200 ps2d = 1;

        //5A
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 1;
        #200 ps2d = 0;
        #200 ps2d = 1;
        #200 ps2d = 0;

        #200 ps2d = 0;
        #200 ps2d = 1;

        
        #500 $finish;
    end


endmodule
