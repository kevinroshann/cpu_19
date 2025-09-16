`timescale 1ns/1ps
module pc (
    input wire clk,
    input wire reset,
    input wire [18:0] pc_in,
    output reg [18:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc_out <= 19'd0;
    end else begin
        pc_out <= pc_in;
    end
end

endmodule
