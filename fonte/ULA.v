module ULA (
    input [15:0] A,
    input [15:0] B,
    input [2:0] OpSelect,
    output reg [15:0] Resul
);

    always @(*) begin
        case (OpSelect)
            3'b000: Resul = A + B;    // Soma
            3'b001: Resul = A - B;    // Subtrai
            3'b010: Resul = ~(A & B); // NAnd
            3'b111: Resul = B;  // Trocar
            default: Resul = 16'b0;     // Caso base zerado
        endcase
    end


endmodule