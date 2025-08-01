module instruction_memory (
    input [15:0] address,
    output reg [15:0] instruction
);

    always @(*) begin
        case (address)
        // Programa vai aqui --------------------------------------------------------------------------------
        
        // Multiplicação de dois numeros positivos
            16'h0000: instruction = 16'b101_001_0000000111; // ldi r1, #7
            16'h0001: instruction = 16'b101_010_0000001001; // ldi r2, #9
            16'h0002: instruction = 16'b101_011_0000000000; // ldi r3, #0
            16'h0003: instruction = 16'b101_100_0000000001; // ldi r4, #1
            16'h0004: instruction = 16'b101_000_0000000000; // ldi r0, #0

            16'h0005: instruction = 16'b110_001_0000000100; // jump #4
            16'h0006: instruction = 16'b000_011_010_0000000; // add, r3, r2
            16'h0007: instruction = 16'b001_001_100_0000000; // sub, r1, r4
            16'h0008: instruction = 16'b110_000_1111111101; // jump #-3

            16'h0009: instruction = 16'b100_011_0000000000; // out r3
            16'h000A: instruction = 16'b011_000_0000000000; // halt   

        // -------------------------------------------------------------------------------------------------------   
            default: instruction = 16'b000_000_000_0000000;   // NOP
        endcase
    end

endmodule

/*
    BASE DE INSTRUÇÕES:
        load: 16'h000x: instruction = 16'b101_000_0000000000; // ldi r0,
        jump: 16'h000x: instruction = 16'b110_00x_0000000000; // jump #0
        out:  16'h000x: instruction = 16'b100_000_0000000000; // out r0
        halt: 16'h000x: instruction = 16'b011_000_0000000000; // halt
        repl: 16'h000x: instruction = 16'b111_000_001_0000000; // rep rx, ry
        sub:  16'h000x: instruction = 16'b001_001_010_0000000;  // sub r1, r2
*/

/*
    TESTE GERAL 1
     // Programa de teste básico para o processador
            16'h0000: instruction = 16'b101_000_0000011100;  // ldi r0, #28
            16'h0001: instruction = 16'b101_001_0000001010;  // ldi r1, #10
            16'h0002: instruction = 16'b001_000_001_0000000;  // sub r0, r1
            16'h0003: instruction = 16'b100_000_0000000000;   // out r0

            // Teste de replace
            16'h0004: instruction = 16'b111_000_001_0000000;
            16'h0005: instruction = 16'b100_000_0000000000;   // out r0
            16'h0006: instruction = 16'b100_001_0000000000;   // out r1

            // Teste de salto: Não salta
            16'h0007: instruction = 16'b110_000_0000000010;    // jump #2
            16'h0008: instruction = 16'b100_000_0000000000;   // out r0

            16'h0009: instruction = 16'b101_000_0000000000;  // ldi r0, #0
            16'h000A: instruction = 16'b100_000_0000000000;   // out r0

            // Teste de salto: Salta para frente
            16'h000B: instruction = 16'b110_000_0000000010;    // jump #2
            16'h000C: instruction = 16'b101_000_0000000100;  // ldi r0, #4

            16'h000D: instruction = 16'b100_000_0000000000;   // out r0
  
            16'h000E: instruction = 16'b011_000_0000000000;   // halt

    -------------------------------------------------------------------------

    TESTE GERAL 2
    // Contagem de 10 a 0
            16'h0000: instruction = 16'b101_001_0000001010;  // ldi r1, #10
            16'h0001: instruction = 16'b101_010_0000000001;  // ldi r2, #1
            16'h0002: instruction = 16'b101_000_0000000000;   // ldi r0, #0
            16'h0003: instruction = 16'b100_001_0000000000;   // out r1
            16'h0004: instruction = 16'b001_001_010_0000000;  // sub r1, r2 <--

            // Teste de salto: Para trás
            16'h0005: instruction = 16'b110_001_0000000010; // jump #2
            16'h0006: instruction = 16'b110_000_1111111101; // jump #-3 (C2)

            16'h0007: instruction = 16'b100_001_0000000000;   // out r1
           
            16'h0008: instruction = 16'b011_000_0000000000;   // halt

    -------------------------------------------------------------------------

    TESTE DE SAÍDA 
    // Teste de saída de sinal no testbench
            16'h0000: instruction = 16'b101_000_0000000001;  // ldi r0, #1
            16'h0001: instruction = 16'b101_001_0000000100;  // ldi r1, #4
            16'h0002: instruction = 16'b001_000_001_0000000;  // sub r1, r0
            16'h0003: instruction = 16'b100_000_0000000000;   // out r0

            16'h0004: instruction = 16'b011_000_0000000000;   // halt

    -------------------------------------------------------------------------

    TESTE 3
    // Multiplicação de dois numeros positivos
            16'h0000: instruction = 16'b101_001_0000000111; // ldi r1, #7
            16'h0001: instruction = 16'b101_010_0000001001; // ldi r2, #9
            16'h0002: instruction = 16'b101_011_0000000000; // ldi r3, #0
            16'h0003: instruction = 16'b101_100_0000000001; // ldi r4, #1
            16'h0004: instruction = 16'b101_000_0000000000; // ldi r0, #0

            16'h0005: instruction = 16'b110_001_0000000100; // jump #4
            16'h0006: instruction = 16'b000_011_010_0000000; // add, r3, r2
            16'h0007: instruction = 16'b001_001_100_0000000; // sub, r1, r4
            16'h0008: instruction = 16'b110_000_1111111101; // jump #-3

            16'h0009: instruction = 16'b100_011_0000000000; // out r3
            16'h000A: instruction = 16'b011_000_0000000000; // halt

    -------------------------------------------------------------------------


*/