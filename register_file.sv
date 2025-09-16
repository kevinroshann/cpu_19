`timescale 1ns/1ps
module register_file (
    input wire clk,
    input wire reset,
    input wire [3:0] rs1,
    input wire [3:0] rs2,
    input wire [3:0] rd,
    input wire [18:0] write_data,
    input wire regwrite,
    output wire [18:0] readdata1,
    output wire [18:0] readdata2
);

reg [18:0] mem [0:15];
integer i;


always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 16; i = i + 1) begin
            mem[i] <= 19'd0;
        end
  
    end else if (regwrite) begin
        if (rd != 4'd0) begin  
            mem[rd] <= write_data;
        end
    end
end

assign readdata1 = (rs1 == 4'd0) ? 19'd0 : mem[rs1];
assign readdata2 = (rs2 == 4'd0) ? 19'd0 : mem[rs2];

endmodule
