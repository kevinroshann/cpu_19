`timescale 1ns/1ps
module control (
    input wire [3:0] opcode,


    input wire program_end,
 output reg alu_use,

    output reg regwrite,
    output reg jump_en,
    output reg branch_en,
    output reg call_en,
    output reg ret_en,
    output reg mem_read,
    output reg mem_write,

    output reg encr_en,
    output reg decr_en,
    output reg fft_en
);


always @(*) begin

regwrite = 1'b0;
 alu_use=1'b0;
jump_en=1'b0;
branch_en=1'b0;
ret_en=1'b0;
call_en=1'b0;
mem_read=1'b0;
mem_write=1'b0;
encr_en=1'b0;
decr_en=1'b0;
fft_en=1'b0;
if(!program_end) begin
    case (opcode)
        4'b0001: begin //r
            regwrite=1'b1;
            alu_use=1'b1;
        end
        4'b0010: begin //i
            regwrite=1'b1;
            alu_use=1'b1;
        end
        4'b0011: begin //j
            jump_en=1'b1;
        end
        4'b0100: begin //b
            branch_en=1'b1;

        end
        4'b0101: begin //ld
            regwrite=1'b1; //we need to wriet to register nd enable the memory read
            mem_read=1'b1;
        end
        4'b0110: begin //sd
            mem_write=1'b1;
        end
        4'b0111: begin //call
            call_en=1'b1;
        end
        4'b1000: begin //ret
           ret_en=1'b1;
        end

    4'b1001: begin //encryption
        mem_read=1'b1;
        mem_write=1'b1;
        encr_en=1'b1;

    end

    4'b1010: begin //decryption
        mem_read=1'b1;
        mem_write=1'b1;
        decr_en=1'b1;
    end

    4'b1011: begin //fft
        mem_read=1'b1;
        mem_write=1'b1;
        fft_en=1'b1;
    end


         default: begin
            regwrite = 1'b0;
            alu_use  = 1'b0;
        end
    endcase
end
end

endmodule //control
