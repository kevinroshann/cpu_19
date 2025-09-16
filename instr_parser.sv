`timescale 1ns/1ps
module instr_parser (
    input wire [18:0] instr,
    output reg [3:0] opcode,
    output reg  [3:0] rs1,
    output reg  [3:0] rs2,
    output reg  [3:0] rd,
    output reg [1:0] funct2,
    output reg [2:0] alu_type,
    output reg [10:0] jump_addr,
    output reg [7:0] branch_addr,
    output reg [7:0] mem_addr,
    output reg [10:0] call_addr
);


always @(*) begin
    opcode =instr[18:15];
//  rs1 = instr[14:11];
//  rs2 = instr[10:7];
//  rd =instr[6:3];
//  alu_type=instr[2:0];
//  funct2=instr[10:9];
rs1=4'd0;
rs2=4'd0;
rd=4'd0;
alu_type=3'd0;
funct2=2'd0;
jump_addr=11'd0;
call_addr=11'd0;
branch_addr=8'd0;
mem_addr=8'd0;


case (opcode)
    4'b0001: begin //R types

rs1=instr[14:11];
rs2=instr[10:7];
rd=instr[6:3];
alu_type=instr[2:0];


    end
    4'b0010: begin// I types
        
rs1=instr[14:11];
funct2=instr[10:9];
rd=instr[6:3];


    end
    4'b0011: begin// jump

    jump_addr=instr[10:0];

    end
    4'b0100: begin//bracn
        
rs1=instr[14:11];
rs2=instr[10:7];
branch_addr=instr[7:0];

    end
    4'b0101: begin //load
        
rd=instr[14:11];
mem_addr=instr[7:0];


    end
     4'b0110: begin //store
        

rs1=instr[14:11];
mem_addr=instr[7:0];


    end
     4'b0111: begin //call
        
        call_addr=instr[10:0];


    end



    4'b1000: begin //ret
        
    end




    4'b1001: begin //encrypition
        rs1=instr[14:11];
mem_addr=instr[7:0];
    end

    4'b1010: begin //decryption
rs1=instr[14:11];
mem_addr=instr[7:0];
    end

    4'b1011: begin //fft
       rs1=instr[14:11];
mem_addr=instr[7:0]; 
    end


    default: begin

rs1=instr[14:11];
rs2=instr[10:7];
rd=instr[6:3];
alu_type=instr[2:0];
    end
endcase
end






endmodule //instr_parser
