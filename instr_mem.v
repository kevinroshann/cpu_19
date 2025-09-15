module instr_mem (
    input  wire [4:0] instr_addr,
    output reg  [18:0] instruction
);

reg [18:0] instr_mem [0:31];
integer i;

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        instr_mem[i] = 19'd0;
    end


// instr_mem[2] =19'b1001_0001_0000_0000000;
instr_mem[3] =19'b1010_0001_0000_0000001;
instr_mem[2] =19'b1011_0001_0000_0000000;
    // instr_mem[0]  = 19'b0101_0001_0000_0000000;
    // instr_mem[1]  = 19'b0101_0010_0000_0000001;
    // instr_mem[2]  = 19'b0111_0000_0000_0010000;
    // instr_mem[3]  = 19'b0110_0011_0000_0000010;
    // instr_mem[4]  = 19'b0101_0100_0000_0000010;
    // instr_mem[5]  = 19'b0111_0000_0000_0011000;
    // instr_mem[6]  = 19'b0110_0101_0000_0000011;
    // instr_mem[7]  = 19'b0101_0110_0000_0000011;
    // instr_mem[8]  = 19'b0101_0111_0000_0000100;
    // instr_mem[9]  = 19'b0111_0000_0000_0011100;
    // instr_mem[10] = 19'b0100_0111_0000_0010011;
    // instr_mem[11] = 19'b0011_0000_0000_0011111;
    // instr_mem[16] = 19'b0001_0001_0010_0011_000;
    // instr_mem[17] = 19'b1000_0000_0000_0000000;
    // instr_mem[24] = 19'b0001_0100_0100_0101_000;
    // instr_mem[25] = 19'b1000_0000_0000_0000000;
    // instr_mem[28] = 19'b0010_0111_0100_0111_000;
    // instr_mem[29] = 19'b1000_0000_0000_0000000;
end

always @(*) begin
    instruction = instr_mem[instr_addr];
end

endmodule
