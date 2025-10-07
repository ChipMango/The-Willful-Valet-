`timescale 1ns/1ps

module timer #(parameter int LIMIT = 100)(
    input logic clk, rst_n, enable,
    output logic done
);
    logic [LIMIT:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 0;
        else if (enable && !done)
            count <= count + 1;
        else if (!enable)
            count <= 0;
    end

    assign done = (count == LIMIT);
endmodule