module instruction_memory (
    input [15:0] address,
    output reg [15:0] instruction
);

    always @(*) begin
        case (address)
        // Programa vai aqui --------------------------------------------------------------------------------
            
            // Contagem simples: 1, 2, 3, 4, 5
            16'h0000: instruction = 16'b101_000_0000000001;  // ldi r0, #1
            16'h0001: instruction = 16'b101_001_0000000101;  // ldi r1, #5
            16'h0002: instruction = 16'b101_010_0000000001;  // ldi r2, #1

            16'h0003: instruction = 16'b100_000_0000000000;  // out r0
            16'h0004: instruction = 16'b000_000_010_0000000; // add r0, r2
            16'h0005: instruction = 16'b001_011_001_0000000; // sub r3, r1
            16'h0006: instruction = 16'b001_011_000_0000000; // sub r3, r0
            16'h0007: instruction = 16'b110_011_0000000001;  // bne r3, #1
            16'h0008: instruction = 16'b111_000_1111111011;  // jmp #-5

            16'h0009: instruction = 16'b011_000_0000000000;  // halt

        // -------------------------------------------------------------------------------------------------------   
            default: instruction = 16'b000_000_000_0000000;   // NOP
        endcase
    end

endmodule

/* Programas de teste

// Calcula fatorial de 4 (4! = 24)
16'h0000: instruction = 16'b101_000_0000000001;  // ldi r0, #1   (resultado = 1)
16'h0001: instruction = 16'b101_001_0000000100;  // ldi r1, #4   (número para fatorial)
16'h0002: instruction = 16'b101_010_0000000001;  // ldi r2, #1   (decrementador)

// Loop: r0 = r0 * r1, depois r1--
16'h0003: instruction = 16'b000_000_001_0000000; // add r0, r1   (multiplicação simulada por somas repetidas)
16'h0004: instruction = 16'b001_001_010_0000000; // sub r1, r2   (r1--)
16'h0005: instruction = 16'b110_001_0000000001;  // bne r1, #1   (se r1=0, pula loop)
16'h0006: instruction = 16'b111_000_1111111101;  // jmp #-3      (volta para o loop)

16'h0007: instruction = 16'b100_000_0000000000;  // out r0       (mostra resultado)
16'h0008: instruction = 16'b011_000_0000000000;  // halt


------------------------------------------------------------------------------------------------

// Fibonacci: 1, 1, 2, 3, 5, 8
16'h0000: instruction = 16'b101_000_0000000001;  // ldi r0, #1   (primeiro número)
16'h0001: instruction = 16'b101_001_0000000001;  // ldi r1, #1   (segundo número)
16'h0002: instruction = 16'b101_010_0000000110;  // ldi r2, #6   (contador de números)
16'h0003: instruction = 16'b101_011_0000000001;  // ldi r3, #1   (decrementador)

16'h0004: instruction = 16'b100_000_0000000000;  // out r0       (mostra número atual)
16'h0005: instruction = 16'b000_000_001_0000000; // add r0, r1   (próximo = atual + anterior)
16'h0006: instruction = 16'b111_001_000_0000000; // rep r1, r0   (anterior = atual)
16'h0007: instruction = 16'b001_010_011_0000000; // sub r2, r3   (contador--)
16'h0008: instruction = 16'b110_010_0000000001;  // bne r2, #1   (se contador=0, sai)
16'h0009: instruction = 16'b111_000_1111111011;  // jmp #-5      (volta para out)

16'h000A: instruction = 16'b011_000_0000000000;  // halt

-------------------------------------------------------------------------------------------------

// Contagem regressiva de 10 até 0
16'h0000: instruction = 16'b101_000_0000001010;  // ldi r0, #10  (contador)
16'h0001: instruction = 16'b101_001_0000000001;  // ldi r1, #1   (decrementador)

// Loop de contagem regressiva
16'h0002: instruction = 16'b100_000_0000000000;  // out r0       (mostra número atual)
16'h0003: instruction = 16'b001_000_001_0000000; // sub r0, r1   (r0--)
16'h0004: instruction = 16'b110_000_0000000001;  // bne r0, #1   (se r0=0, sai)
16'h0005: instruction = 16'b111_000_1111111101;  // jmp #-3      (volta para out)

16'h0006: instruction = 16'b011_000_0000000000;  // halt


*/