module decodificador (
    input [15:0] instrucao,
    output wire [2:0] opcode,
    output wire [2:0] RX,
    output wire [2:0] RY
);

    assign opcode = instrucao [15:13];
    assign RX = instrucao [12:10];
    assign RY = instrucao [9:7];

endmodule