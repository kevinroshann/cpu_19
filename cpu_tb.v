`timescale 1ns/1ps

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
    wire [1:0] funct2_out;
    wire [1:0] type_out;
    wire [10:0] jump_addr_out;
    wire [7:0] branch_addr_out;
    wire [7:0] mem_addr_out;
    wire [10:0] call_addr_out;
    wire [18:0] readdata1_out;
    wire [18:0] readdata2_out;
    wire [18:0] result_out;
    wire [18:0] alu_b_out;
    wire [18:0] mem_data_out;
    wire [18:0] write_data_out;
    wire regwrite_out;
    wire alu_use_out;
    wire branch_en_out;
    wire jump_en_out;
    wire mem_read_out;
    wire mem_write_out;
    wire call_en_out;
    wire ret_en_out;
    wire pc_src_out;
    wire zero_out;
    wire [18:0] pc_out;
    wire [18:0] pc_next_out;
    wire [3:0] sp_out;
    wire [18:0] stack_top_out;
    wire stack_empty_out;
    wire stack_full_out;
    wire encr_en_out;
    wire decr_en_out;
    wire [18:0] encr_result_out;
    wire fft_en_out;
    wire [18:0] fft_result_out;

cpu cpu_dut(
    .clk(clk),
    .reset(reset),
    .instruction_out(instruction_out),
    .opcode_out(opcode_out),
    .alu_op_out(alu_op_out),
    .alu_type_out(alu_type_out),
    .rs1_out(rs1_out),
    .rs2_out(rs1_out),
    .rd_out(rd_out),
    .pc_out(pc_out),
    .pc_next_out(pc_next_out),
    .sp_out(sp_out),
    .write_data_out(write_data_out),
    .mem_data_out(mem_data_out),
    .readdata1_out(readdata1_out),
    .readdata2_out(readdata2_out),
    .result_out(result_out),

    .jump_addr_out(jump_addr_out),
    .branch_addr_out(branch_addr_out),
    .encr_en_out(encr_en_out),
    .decr_en_out(decr_en_out),
    .encr_result_out(encr_result_out),
    .fft_en_out(fft_en_out),
    .fft_result_out(fft_result_out)
);





initial begin
    clk =0;
    forever #5 clk=~clk;
end

initial begin
    $dumpfile("cpu_test.vcd");
    $dumpvars(0,cpu_tb);
    reset=1;
    #10;
    reset =0;
    repeat(3) begin
        @(posedge clk);
        #2;
        // $display("Time = %0t \t instructino=  %b \t pc_out=%b \t rs1_out=%0d rs2_out=%0d rd_out=%0d read_data1=%0d \t read_data_2%0d \t writedata= %0d \t",
        // $time; instruction_out;pc_out;rs1_out;rs2_out;rd_out;readdata1_out;readdata2_out;write_data_out);


              $display("Time = %0t \t instructino=  %b \t pc_out=%d \t opcode=%b \t aluop=%b\t alu_type=%b\t rs1_out=%0d rs2_out=%0d rd_out=%0d jump_addr=%b branchaddr=%b result =%b enena=%b decena%b encres%b memdata=%b fften=%b fftres=%b",
        $time,instruction_out,pc_out, 
        
        opcode_out,alu_op_out,alu_type_out,
        rs1_out,rs2_out,rd_out,jump_addr_out,branch_addr_out,result_out,encr_en_out,decr_en_out,encr_result_out,mem_data_out,fft_en_out,fft_result_out);
    end
    $finish;
end

endmodule


