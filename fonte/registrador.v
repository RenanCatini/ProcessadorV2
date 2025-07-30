module registrador (
    input clock,
    input enable,
    input [15:0] entrada,
    output reg [15:0] saida
);

    always @(posedge clock) begin
        if (enable)
            saida <= entrada;
    end

endmodule