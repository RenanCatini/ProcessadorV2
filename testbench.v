`include "processor.v"

module testbench;
    reg clock = 0;
    reg resetn = 1;
    wire [15:0] bus;
    wire halt;  // NOVO: recebe sinal de halt do processador
    
    // Clock de 2 unidades de tempo (período = 2)
    always #1 clock = !clock;
    
    // Configuração de dump para visualização
    initial $dumpfile("build/testeProcessador.vcd");
    initial $dumpvars(0, testbench);

    // Instanciar processador (agora com halt)
    processor p(.clock(clock), .resetn(resetn), .bus(bus), .halt(halt));
    
    // Mostra saídas do bus
    always @(posedge clock) begin
        if (p.bus_enable) begin
            $display("Saída: %0d", bus);
        end
    end
    
    // Detecta halt automaticamente
    always @(posedge halt) begin
        $display("\n*** PROGRAMA FINALIZADO ***");
        #2 $finish;  // Pequena pausa antes de finalizar
    end
    
    initial begin
        $display("=== SIMULAÇÃO INICIADA ===");
        
        // Reset inicial
        #1 resetn = 1'b1;  // Ativa reset
        #2 resetn = 1'b0;  // Desativa reset - processador começa
                
        // Timeout de segurança (caso esqueça o HALT)
        #1000 begin
            $display("\nTIMEOUT: Programa não finalizou em 1000 ciclos!");
            $display("Verifique se há instrução HALT no final do programa.");
            $finish;
        end
    end

endmodule