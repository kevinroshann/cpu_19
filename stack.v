module stack (
    input wire clk,
    input wire reset,
    input wire [18:0] push_data,
    input wire push,
    input wire pop,
    output reg [18:0] pop_data,
    output reg [3:0] sp,
    output wire stack_empty,
    output wire stack_full
);

integer i;
reg [18:0] stack_mem [0:15];

always @(posedge clk or posedge reset) begin
    if(reset) begin
        sp <= 4'd15;
        for(i = 0; i < 16; i = i + 1) begin
            stack_mem[i] <= 19'd0;
        end
    end
    else begin
        if(push && !stack_full) begin
            sp <= sp - 4'd1;
            stack_mem[sp - 4'd1] <= push_data;
        end
        else if(pop && !stack_empty) begin
            sp <= sp + 4'd1;
        end
    end
end

always @(*) begin
    if (!stack_empty) begin
        pop_data = stack_mem[sp];
    end
    else
        pop_data = 19'd0;
end

assign stack_empty = (sp >= 4'd15);
assign stack_full = (sp == 4'd0);

endmodule