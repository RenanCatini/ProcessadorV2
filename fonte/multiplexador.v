module multiplexador (
    input [15:0] r0,
    input [15:0] r1,
    input [15:0] r2,
    input [15:0] r3,
    input [15:0] r4,
    input [15:0] r5,
    input [15:0] r6,
    input [15:0] r7,
    input [15:0] R,
    input [15:0] imm,
    input [3:0] sel,
    output reg [15:0] saida
);

    always @(*) begin
        case (sel)
            4'b0000: saida = r0;
            4'b0001: saida = r1;
            4'b0010: saida = r2;
            4'b0011: saida = r3;
            4'b0100: saida = r4;
            4'b0101: saida = r5;
            4'b0110: saida = r6;
            4'b0111: saida = r7;
            4'b1000: saida = imm;
            4'b1001: saida = R;
            default: saida = 16'b0;
        endcase
    end

endmodule