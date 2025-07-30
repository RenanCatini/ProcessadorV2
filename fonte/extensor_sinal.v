module extensor_sinal (
    input [15:0] instrucao,
    output reg [15:0] imediato
);

    always @(*) begin
        if (instrucao[9])
            imediato = {6'b111111, instrucao[9:0]};
        else
            imediato = {6'b000000, instrucao[9:0]};
    end

endmodule