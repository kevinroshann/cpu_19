`timescale 1ns/1ps
module data_memory (
    input wire clk,
    input wire reset,
    input wire [3:0] addr,
    input wire [18:0] write_data,
    input wire mem_write,
    input wire mem_read,
    output reg [18:0] read_data
);

reg [18:0] data_mem [0:15];
integer i;

initial begin
    for (i = 0; i < 16; i = i + 1) begin
        data_mem[i] = 19'd0;
    end
    data_mem[0] = 19'd5;
    data_mem[1] = 19'd7;
    data_mem[2] = 19'd0;
    data_mem[3] = 19'd0;
    data_mem[4] = 19'd3;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 16; i = i + 1) begin
            data_mem[i] <= 19'd0;
        end
        data_mem[0] <= 19'd5;
        data_mem[1] <= 19'b0011010001010110110;
        data_mem[2] <= 19'd0;
        data_mem[3] <= 19'd0;
        data_mem[4] <= 19'd3;
    end else if (mem_write) begin
        data_mem[addr] <= write_data;
    end
end

always @(*) begin
    if (mem_read) begin
        read_data = data_mem[addr];
    end else begin
        read_data = 19'd0;
    end
end

endmodule
