module instruction_memory (
    input [15:0] address,
    output reg [15:0] instruction
);

    // Programa de debug ultra-simples
    always @(*) begin
        case (address)
            16'h0000: instruction = 16'b101_000_0000000010;  // ldi r0, #2  (multiplicando)
            16'h0001: instruction = 16'b101_001_0000000010;  // ldi r1, #2  (contador)
            16'h0002: instruction = 16'b101_010_0000000000;  // ldi r2, #0  (resultado)
            16'h0003: instruction = 16'b101_011_0000000001;  // ldi r3, #1  (constante para decrementar)
            
            // Loop de multiplicação
            16'h0004: instruction = 16'b000_010_000_0000000; // add r2, r0  (r2 = r2 + r0)
            16'h0005: instruction = 16'b001_001_011_0000000; // sub r1, r3  (r1 = r1 - 1)  
            16'h0006: instruction = 16'b110_001_1111111110;  // bne r1, #-2 (se r1!=0, volta para 0x0004)
                                                            // PC=6, new_pc = 6+(-2) = 4
            
            16'h0007: instruction = 16'b100_010_0000000000;  // out r2      (mostra resultado)
            
            default: instruction = 16'b000_000_000_0000000;   // NOP
        endcase
    end

endmodule