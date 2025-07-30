`include "processor.v"

module testbench;
    reg clock = 0;
    reg resetn = 1;
    wire [15:0] bus;
    
    // Clock de 2 unidades de tempo (período = 2)
    always #1 clock = !clock;
    
    // Configuração de dump para visualização
    initial $dumpfile("build/testeProcessador.vcd");
    initial $dumpvars(0, testbench);

    // Instanciar processador (sem entrada manual de instruções)
    processor p(.clock(clock), .resetn(resetn), .bus(bus));
    
    initial begin
        
        // Reset inicial
        #1 resetn = 1'b1;  // Ativa reset
        #2 resetn = 1'b0;  // Desativa reset - processador começa
    
        // Aguarda mais um pouco para ver o resultado final
        #90
            
        #8 $finish;       
    end

endmodule