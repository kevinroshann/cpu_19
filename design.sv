`timescale 1ns/1ps



// `include "alu_control.sv"
// `include "branch.sv"
// `include "data_memory.sv"
// `include "fft.sv"
// `include "instr_parser.sv"
// `include "alu.sv"
// `include "control.sv"
// `include "encrdecr.sv"
// `include "instr_mem.sv"
// `include "pc.sv"
// `include "register_file.sv"
// `include "stack.sv"
// `include "subroutine.sv"
// `include "type_decode.sv"



module cpu (
    input wire clk,
    input wire reset,
    

    output wire [18:0] instruction_out,
    output wire [3:0] opcode_out,
    output wire [3:0] rs1_out,
    output wire [3:0] rs2_out,
    output wire [3:0] rd_out,
    output wire [2:0] alu_type_out,
    output wire [2:0] alu_op_out,
    output wire [1:0] funct2_out,
    output wire [1:0] type_out,
    output wire [10:0] jump_addr_out,
    output wire [7:0] branch_addr_out,
    output wire [7:0] mem_addr_out,
    output wire [10:0] call_addr_out,
    output wire [18:0] readdata1_out,
    output wire [18:0] readdata2_out,
    output wire [18:0] result_out,
    output wire [18:0] alu_b_out,
    output wire [18:0] mem_data_out,
    output wire [18:0] write_data_out,
    output wire regwrite_out,
    output wire alu_use_out,
    output wire branch_en_out,
    output wire jump_en_out,
    output wire mem_read_out,
    output wire mem_write_out,
    output wire call_en_out,
    output wire ret_en_out,
    output wire pc_src_out,
    output wire zero_out,
    output wire [18:0] pc_out,
    output wire [18:0] pc_next_out,
    output wire [3:0] sp_out,
    output wire [18:0] stack_top_out,
    output wire stack_empty_out,
    output wire stack_full_out,
    output wire encr_en_out, decr_en_out,
    output wire [18:0] encr_result_out,
    output wire [18:0] fft_result_out,
    output wire fft_en_out
);

    wire [18:0] instruction;
    wire [3:0]  opcode, rs1, rs2, rd;
    wire [2:0]  alu_type, alu_op;
    wire [1:0]  funct2, types;
    wire [10:0] jump_addr, call_addr;
    wire [7:0]  branch_addr, mem_addr;
    wire [18:0] readdata1, readdata2, result, alu_b, mem_data, write_data;
    wire regwrite, alu_use, branch_en, jump_en, mem_read, mem_write, call_en, ret_en, pc_src, zero;
    wire [18:0] pc_out_internal, pc_next, pc_in;
    wire [18:0] subroutine_pc_next;
    wire subroutine_pc_src;
    // wire encr_en, decr_en,fft_en;
    wire [18:0] encr_result,fft_result;
    reg program_end;

   




pc p1 (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out_internal)
    );


    always @(*) begin
        program_end = (pc_out_internal > 19'd31);
    end










    instr_mem instr_mem1 (
        .instr_addr(pc_out_internal[4:0]), 
        .instruction(instruction)
    );
instr_parser instr_parser1 (
        .instr(instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .alu_type(alu_type),
        .funct2(funct2),
        .jump_addr(jump_addr),
        .branch_addr(branch_addr),
        .mem_addr(mem_addr),
        .call_addr(call_addr)
    );


    type_decode type_decoder1 (
        .opcode(opcode),
        .types(types)
    );


    alu_control alu_control1 (
        .types(types),
        .alu_type(alu_type),
        .funct2(funct2),
        .alu_op(alu_op)
    );


    register_file register_file1 (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),


        .write_data(write_data),
        .regwrite(regwrite && !program_end),
        .readdata1(readdata1),
        .readdata2(readdata2)
    );


    data_memory data_mem1 (
        .clk(clk),
        .reset(reset),
        .addr(mem_addr[3:0]), 
        .write_data((encr_en_out || decr_en_out) ? encr_result : ((fft_en_out) ? fft_result : readdata1)), 
        .mem_write(mem_write && !program_end),  
        .mem_read(mem_read),   
        .read_data(mem_data)   
    );

    subroutine subroutine1 (
        .clk(clk),
        .reset(reset),
    

        .opcode(opcode),
        .pc_current(pc_out_internal),
        .call_addr(call_addr),
        .call_en(call_en),
        .ret_en(ret_en),
        .program_end(program_end),
        .pc_next(subroutine_pc_next),
        .pc_src(subroutine_pc_src),
        .stack_top(stack_top_out),
        .sp_out(sp_out),
        .stack_empty(stack_empty_out),
        .stack_full(stack_full_out)
    );


    assign alu_b = (types == 2'b01 && (funct2 == 2'b00 || funct2 == 2'b01)) ? 19'd1 : readdata2;


    alu alu1 (
        .alu_op(alu_op),
        .a(readdata1),
        .b(alu_b),
        .result(result),
        .zero(zero)
    );




    branch branch1 (
        .types(types),
        .opcode(opcode),
        .readdata1(readdata1),


        .readdata2(readdata2),
        .pc_current(pc_out_internal),
        .jump_addr(jump_addr),

        .branch_addr(branch_addr),
        .subroutine_pc_next(subroutine_pc_next),
        .subroutine_pc_src(subroutine_pc_src),
        .pc_next(pc_next),
        .pc_src(pc_src),




        .program_end(program_end)
    );


    control control1 (
        .opcode(opcode),
    
        .regwrite(regwrite),



        .alu_use(alu_use),
        .branch_en(branch_en),
        .jump_en(jump_en),
        .mem_read(mem_read),
        .mem_write(mem_write),



        .call_en(call_en),
        .ret_en(ret_en),
        .program_end(program_end),

        .encr_en(encr_en_out),
        .decr_en(decr_en_out),
        .fft_en(fft_en_out)
    );

   encrdecr encrdecr1(
        .a(mem_data),
        .encr_en(encr_en_out),
        .decr_en(decr_en_out),
        .result(encr_result)
    );

fft fft1(
    .a(mem_data),
    .fft_en(fft_en_out),
    .fft_result(fft_result)
);









    assign write_data = (opcode == 4'b0101) ? mem_data : 
                       ((encr_en_out || decr_en_out) ? encr_result : ((fft_en_out) ? fft_result : result));

// if(opcode == 4'b0101) begin
//     write_data=mem_data;
// end
// else if (encr_en || decr_en) begin
//     write_data=encr_result;
// end
// else if (fft_en) begin
//     write_data=fft_result;
// end
// else
//     write_data=result;


    assign pc_in = program_end ? pc_out_internal : (pc_src ? pc_next : (pc_out_internal + 19'd1));
    

    assign instruction_out = instruction;
    assign opcode_out = opcode;
    assign rs1_out = rs1;
    assign rs2_out = rs2;
    assign rd_out = rd;

    assign alu_type_out = alu_type;


    assign alu_op_out = alu_op;
    assign funct2_out = funct2;
    assign type_out = types;


    assign jump_addr_out = jump_addr;
    assign branch_addr_out = branch_addr;
    assign mem_addr_out = mem_addr;
    assign call_addr_out = call_addr;


    assign readdata1_out = readdata1;
    assign readdata2_out = readdata2;
    assign result_out = result;
    assign alu_b_out = alu_b;
assign mem_data_out = mem_data;


    assign write_data_out = write_data;
    assign regwrite_out = regwrite;
    assign alu_use_out = alu_use;
    assign branch_en_out = branch_en;
    assign jump_en_out = jump_en;

assign mem_read_out = mem_read;
assign mem_write_out = mem_write;
assign call_en_out = call_en;
assign ret_en_out = ret_en;
assign pc_src_out = pc_src;




    assign zero_out = zero;
    assign pc_out = pc_out_internal;
    assign pc_next_out = pc_next;
    //     assign encr_en_out = encr_en_out;
    // assign decr_en_out = decr_en_out;
    assign encr_result_out = encr_result;
assign fft_result_out=fft_result;
// assign fft_en_out=fft_en_out;
endmodule
