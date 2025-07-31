`include "counter.v"
`include "unidControle.v"
`include "registrador.v"
`include "extensor_sinal.v"
`include "multiplexador.v"
`include "ULA.v"
`include "decodificador.v"
`include "decode_reg.v"
`include "program_counter.v"
`include "instruction_memory.v"

module processor (
    input clock,
    input resetn,
    output wire [15:0] bus,
    output wire halt    // NOVO: sinal de halt para o testbench
);

    // Fios existentes
    wire [2:0] OpSelect;
    wire [7:0] reg_enable;
    wire A_enable, R_enable, clear, bus_enable;
    wire [3:0] selReg;
    wire [1:0] step;

    wire [15:0] r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
    wire [15:0] A_out, R_out, imm;

    wire [15:0] mux_out;
    wire [15:0] ula_out;

    // Novos fios para PC e memória
    wire [15:0] pc_out;
    wire [15:0] instruction;
    wire pc_enable, pc_load;
    wire [15:0] new_pc;

    // Instanciar contador (ciclos de instrução)
    counter contador (.clear(clear), .clock(clock), .out(step));

    // Instanciar Program Counter
    program_counter pc (
        .clock(clock), 
        .clear(resetn), 
        .enable(pc_enable), 
        .load(pc_load), 
        .new_pc(new_pc), 
        .pc_out(pc_out)
    );

    // Instanciar memória de instruções
    instruction_memory mem (
        .address(pc_out), 
        .instruction(instruction)
    );

    // Cálculo do novo PC para desvios 
    // O PC já aponta para a próxima instrução, então: PC_atual + deslocamento
    assign new_pc = pc_out + imm;

    // Instanciar unidade de controle (agora com halt)
    unidControle UDC (
        .instrucao(instruction),
        .resetn(resetn), 
        .step(step), 
        .OpSelect(OpSelect), 
        .reg_enable(reg_enable),
        .A_enable(A_enable), 
        .R_enable(R_enable), 
        .clear(clear), 
        .selReg(selReg), 
        .bus_enable(bus_enable),
        .pc_enable(pc_enable),
        .pc_load(pc_load),
        .halt(halt),              // NOVO: conecta sinal halt
        .mux_out(mux_out)
    );

    // Instanciar registradores (sem mudanças)
    registrador r0 (clock, reg_enable[7], mux_out, r0_out);
    registrador r1 (clock, reg_enable[6], mux_out, r1_out);
    registrador r2 (clock, reg_enable[5], mux_out, r2_out);
    registrador r3 (clock, reg_enable[4], mux_out, r3_out);
    registrador r4 (clock, reg_enable[3], mux_out, r4_out);
    registrador r5 (clock, reg_enable[2], mux_out, r5_out);
    registrador r6 (clock, reg_enable[1], mux_out, r6_out);
    registrador r7 (clock, reg_enable[0], mux_out, r7_out);

    registrador A (clock, A_enable, mux_out, A_out);
    registrador R (clock, R_enable, ula_out, R_out);

    // Instanciar Extensor de sinal (usando instrução da memória)
    extensor_sinal extensor (.instrucao(instruction), .imediato(imm));

    // Instanciar Multiplexador (sem mudanças)
    multiplexador mux(
        r0_out, r1_out, r2_out, r3_out,
        r4_out, r5_out, r6_out, r7_out,
        R_out, imm, selReg, mux_out
    );

    // Instanciar a ULA (sem mudanças)
    ULA ula (A_out, mux_out, OpSelect, ula_out);

    // Saida do barramento - mostra linha "desligada" quando bus_enable = 0
    assign bus = (bus_enable) ? mux_out : 16'hZZZZ;
    
endmodule