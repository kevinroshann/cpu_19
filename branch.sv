`timescale 1ns/1ps
module branch (
    input wire [1:0] types,
    input wire [3:0] opcode,
    input wire [18:0] readdata1,
    input wire [18:0] readdata2,
    input wire [18:0] pc_current,
    input wire [10:0] jump_addr,
    input wire [7:0] branch_addr,
    input wire [18:0] subroutine_pc_next,
    input wire subroutine_pc_src,
    input wire program_end,

    output reg [18:0] pc_next,
    output reg pc_src

);


always @(*) begin
    pc_src=1'b0;
    pc_next=pc_current+19'd1;
    if(!program_end) begin
    
    if(subroutine_pc_src)begin //call and ret have priority
    
    pc_src=1'b1;
    pc_next=subroutine_pc_next;
    
    
    end
    else
        begin

case (types)
    2'b10:begin //for jump

    if(opcode==4'b0011) begin
        pc_src=1'b1;
        pc_next={8'd0,jump_addr};
    end

    end
    2'b11: begin //bracnh
        if(opcode==4'b0100) begin
            if(branch_addr[0]==1'b0) begin
                if(readdata1==readdata2) begin
                    pc_src=1'b1;
                    pc_next={12'd0,branch_addr[7:1]};
                end
            end else if(branch_addr[0]==1'b1) begin
                if(readdata1!=readdata2) begin
                    pc_src=1'b1;
                    pc_next={12'd0,branch_addr[7:1]};
                end
            end
        end
    end
    default: begin
        pc_src=1'b0;
      
    end
endcase

        end
    
    end
    else
        begin
            pc_src=1'b0;
            pc_next=pc_current; //progrm ends and stay at curent pc
        end
end

endmodule //branch
