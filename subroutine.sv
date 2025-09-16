`timescale 1ns/1ps
module subroutine (
    input wire clk,
    input wire reset,

    input wire [3:0] opcode,
    input wire [18:0] pc_current,
    input wire [10:0] call_addr,
    input wire call_en,
    input wire ret_en,
    input wire program_end,
    output reg [18:0] pc_next,
    output reg pc_src,  // 1 if call/ret taken, 0 for normal increment
    output wire [18:0] stack_top,  // For debugging
    output wire [3:0] sp_out,      // For debugging
    output wire stack_empty,
    output wire stack_full
);

// Stack for storing return addresses
wire [18:0] pop_data;
reg [18:0] push_data;
reg push, pop;

stack stack_inst (
    .clk(clk),
    .reset(reset),
    .push_data(push_data),
    .push(push),

    .pop(pop),
    .pop_data(pop_data),
    .sp(sp_out),
    .stack_empty(stack_empty),

    .stack_full(stack_full)

);

assign stack_top = pop_data;

always @(*) begin

    pc_src = 1'b0;
    pc_next = pc_current + 19'd1;
    push = 1'b0;

    pop = 1'b0;
    push_data = 19'd0;
    
    if (!program_end) begin
        if (opcode == 4'b0111 && call_en) begin 
            if (!stack_full) begin
                pc_src = 1'b1;


                pc_next = {8'd0, call_addr}; 
                push = 1'b1;
                push_data = pc_current + 19'd1; 
            end

        end else if (opcode == 4'b1000 && ret_en) begin 
            if (!stack_empty) begin

                pc_src = 1'b1;
                pc_next = pop_data;  
                
                pop = 1'b1;
            end
        end
    end else begin

        pc_next = pc_current;
    end
end

endmodule
