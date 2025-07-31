module instruction_memory (
    input [15:0] address,
    output reg [15:0] instruction
);

    always @(*) begin
        case (address)
            // Inicialização
            16'h0000: instruction = 16'b101_000_0000000000;  // ldi r0, #0   (soma = 0)
            16'h0001: instruction = 16'b101_001_0000000101;  // ldi r1, #5   (contador = 5)
            16'h0002: instruction = 16'b101_010_0000000001;  // ldi r2, #1   (constante para decrementar)
            
            // Loop: r0 = r0 + r1, depois r1--
            16'h0003: instruction = 16'b000_000_001_0000000; // add r0, r1   (soma += contador)
            16'h0004: instruction = 16'b001_001_010_0000000; // sub r1, r2   (contador--)
            16'h0005: instruction = 16'b110_001_1111111110;  // bne r1, #-2  (se contador≠0, volta para add)
            
            // Mostrar resultado
            16'h0006: instruction = 16'b100_000_0000000000;  // out r0       (mostra soma = 15)
            
            // Vamos fazer mais um teste: contar até 3 e mostrar cada número
            16'h0007: instruction = 16'b101_011_0000000001;  // ldi r3, #1   (contador2 = 1)  
            16'h0008: instruction = 16'b101_100_0000000011;  // ldi r4, #3   (limite = 3)
            16'h0009: instruction = 16'b101_101_0000000001;  // ldi r5, #1   (incremento)
            
            // Loop 2: mostrar números de 1 a 3
            16'h000A: instruction = 16'b100_011_0000000000;  // out r3       (mostra número atual)
            16'h000B: instruction = 16'b000_011_101_0000000; // add r3, r5   (r3++)
            16'h000C: instruction = 16'b001_100_011_0000000; // sub r4, r3   (temp = limite - contador)
            16'h000D: instruction = 16'b110_100_1111111101;  // bne r4, #-3  (se temp≠0, continua loop)
            
            // NOVO: Finalizar programa
            16'h000E: instruction = 16'b011_000_0000000000;  // halt         (finaliza programa)
            
            default: instruction = 16'b000_000_000_0000000;   // NOP
        endcase
    end

endmodule