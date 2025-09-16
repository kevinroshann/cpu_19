`timescale 1ns/1ps


// `include "design.sv"


module cpu_tb;
    reg clk;
    reg reset;

    wire [18:0] instruction_out;
    wire [3:0] opcode_out;
    wire [3:0] rs1_out;
    wire [3:0] rs2_out;
    wire [3:0] rd_out;
    wire [2:0] alu_type_out;
    wire [2:0] alu_op_out;
    wire [10:0] jump_addr_out;
    wire [7:0] branch_addr_out;
    wire [18:0] result_out;
    wire [18:0] mem_data_out;
    wire encr_en_out;
    wire decr_en_out;
    wire [18:0] encr_result_out;
    wire fft_en_out;
    wire [18:0] fft_result_out;
    wire [18:0] pc_out;

    /* verilator lint_off PINCONNECTEMPTY */
    cpu cpu_dut(
        .clk(clk),
        .reset(reset),

        .instruction_out(instruction_out),
        .opcode_out(opcode_out),
        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .rd_out(rd_out),
        .alu_type_out(alu_type_out),
        .alu_op_out(alu_op_out),
        .jump_addr_out(jump_addr_out),
        .branch_addr_out(branch_addr_out),
        .result_out(result_out),
        .mem_data_out(mem_data_out),
        .encr_en_out(encr_en_out),
        .decr_en_out(decr_en_out),
        .encr_result_out(encr_result_out),
        .fft_en_out(fft_en_out),
        .fft_result_out(fft_result_out),
        .pc_out(pc_out),

        // Ignore all unused outputs
        .funct2_out(),
        .type_out(),
        .mem_addr_out(),
        .call_addr_out(),
        .readdata1_out(),
        .readdata2_out(),
        .alu_b_out(),
        .write_data_out(),
        .regwrite_out(),
        .alu_use_out(),
        .branch_en_out(),
        .jump_en_out(),
        .mem_read_out(),
        .mem_write_out(),
        .call_en_out(),
        .ret_en_out(),
        .pc_src_out(),
        .zero_out(),
        .pc_next_out(),
        .sp_out(),
        .stack_top_out(),
        .stack_empty_out(),
        .stack_full_out()
    );
    /* verilator lint_on PINCONNECTEMPTY */

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("cpu_test.vcd");
        $dumpvars(0, cpu_tb);
        reset = 1;
        #10;
        reset = 0;
        repeat(3) begin
            @(posedge clk);
            #2;
            $display("Time = %0t \t instructino=  %b \t pc_out=%d \t opcode=%b \t aluop=%b\t alu_type=%b\t rs1_out=%0d rs2_out=%0d rd_out=%0d jump_addr=%b branchaddr=%b result =%b enena=%b decena%b encres%b memdata=%b fften=%b fftres=%b",
                $time, instruction_out, pc_out, opcode_out, alu_op_out, alu_type_out,
                rs1_out, rs2_out, rd_out, jump_addr_out, branch_addr_out, result_out,
                encr_en_out, decr_en_out, encr_result_out, mem_data_out, fft_en_out, fft_result_out);
        end
        $finish;
    end
endmodule
