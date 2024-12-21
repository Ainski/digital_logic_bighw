module key_translate(
    input           clk,
    input           PS2D,
    input           PS2C,
    output reg [7:0] key_code,
    output ready_wire
);
    wire [15:0] key;

    reg ready;
    reg ready_last;
    assign ready_wire = ready&~ready_last;
    always@( posedge clk or posedge rst )
    begin

        ready_last <= ready;
    end
    PS2 ps2(
        .clk(clk),
        .rst(1'b0),
        .PS2D(PS2D),
        .PS2C(PS2C),
        .key(key)
    );
    always@( posedge clk)
    begin
        case(key)
        16'hf01c: begin  // A
            key_code = 8'h41;
            ready = 1;
        end
        16'hf032: begin  // B
            key_code = 8'h42;
            ready = 1;
        end
        16'hf021: begin  // C
            key_code = 8'h43;
            ready = 1;
        end
        16'hf023: begin  // D
            key_code = 8'h44;
            ready = 1;
        end
        16'hf024: begin  // E
            key_code = 8'h45;
            ready = 1;
        end
        16'hf02b: begin  // F
            key_code = 8'h46;
            ready = 1;
        end
        16'hf034: begin  // G
            key_code = 8'h47;
            ready = 1;
        end
        16'hf033: begin  // H
            key_code = 8'h48;
            ready = 1;
        end
        16'hf043: begin  // I
            key_code = 8'h49;
            ready = 1;
        end
        16'hf03b: begin  // J
            key_code = 8'h4a;
            ready = 1;
        end
        16'hf042: begin  // K
            key_code = 8'h4b;
            ready = 1;
        end
        16'hf04b: begin  // L
            key_code = 8'h4c;
            ready = 1;
        end
        16'hf03a: begin  // M
            key_code = 8'h4d;
            ready = 1;
        end
        16'hf031: begin  // N
            key_code = 8'h4e;
            ready = 1;
        end
        16'hf044: begin  // O
            key_code = 8'h4f;
            ready = 1;
        end
        16'hf04d: begin  // P
            key_code = 8'h50;
            ready = 1;
        end
        16'hf015: begin  // Q
            key_code = 8'h51;
            ready = 1;
        end
        16'hf02d: begin  // R
            key_code = 8'h52;
            ready = 1;
        end
        16'hf01b: begin  // S
            key_code = 8'h53;
            ready = 1;
        end
        16'hf02c: begin  // T
            key_code = 8'h54;
            ready = 1;
        end
        16'hf03c: begin  // U
            key_code = 8'h55;
            ready = 1;
        end
        16'hf02a: begin  // V
            key_code = 8'h56;
            ready = 1;
        end
        16'hf01d: begin  // W
            key_code = 8'h57;
            ready = 1;
        end
        16'hf022: begin  // X
            key_code = 8'h58;
            ready = 1;
        end
        16'hf035: begin  // Y
            key_code = 8'h59;
            ready = 1;
        end
        16'hf01a: begin  // Z
            key_code = 8'h5a;
            ready = 1;
        end
        16'hf045: begin  // 0
            key_code = 8'h30;
            ready = 1;
        end
        16'hf016: begin  // 1
            key_code = 8'h31;
            ready = 1;
        end
        16'hf01e: begin  // 2
            key_code = 8'h32;
            ready = 1;
        end
        16'hf026: begin  // 3
            key_code = 8'h33;
            ready = 1;
        end
        16'hf025: begin  // 4
            key_code = 8'h34;
            ready = 1;
        end
        16'hf02e: begin  // 5
            key_code = 8'h35;
            ready = 1;
        end
        16'hf036: begin  // 6
            key_code = 8'h36;
            ready = 1;
        end
        16'hf03d: begin  // 7
            key_code = 8'h37;
            ready = 1;
        end
        16'hf03e: begin  // 8
            key_code = 8'h38;
            ready = 1;
        end
        16'hf046: begin  // 9
            key_code = 8'h39;
            ready = 1;
        end
        16'hf029: begin  // Space
            key_code = 8'h20;
            ready = 1;
        end
        16'hf05a: begin  // Enter
            key_code = 8'h0d;
            ready = 1;
        end
        default: begin
            key_code = 8'h00;
            ready = 0;
        end
        endcase
    end

    
endmodule