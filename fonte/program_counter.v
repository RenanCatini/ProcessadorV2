module program_counter(
    input clock,
    input clear,
    input enable,
    input load,
    input [15:0] new_pc,
    output reg  [15:0] pc_out
);

always @(posedge clock) begin
        if (clear) begin
            pc_out <= 16'b0;  // Reset: PC volta para 0
        end else if (enable) begin
            if (load)
                pc_out <= new_pc;      // Carrega novo PC (desvio)
            else
                pc_out <= pc_out + 1;  // Incrementa PC normalmente
        end
    end

endmodule