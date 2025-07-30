module counter(clock, clear, out);
    input clear;
    input clock;
    output reg [1:0] out;

    always @(posedge clock)
        begin
            if(clear == 1)
                out <= 2'b00;
            else
                out <= out + 1'b1;
        end
endmodule