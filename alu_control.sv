`timescale 1ns/1ps
module alu_control (
    input wire [1:0] types,
    input wire [2:0] alu_type,
    input wire [1:0] funct2,
    output reg [2:0] alu_op
);

localparam ADD=3'b000;
localparam SUB=3'b001;
localparam MUL=3'b010;
localparam DIV=3'b011;
localparam AND=3'b100;
localparam OR=3'b101;
localparam XOR=3'b110;
localparam NOT=3'b111;

always @(*) begin
    case (types)

        2'b00: begin  //R types
        
            case (alu_type)
                ADD: alu_op=ADD;
                SUB: alu_op=SUB;
                MUL: alu_op=MUL;
                DIV: alu_op=DIV;
                AND:alu_op=AND;
                OR:alu_op=OR;
                XOR:alu_op=XOR;
                NOT:alu_op=NOT;
                default:alu_op=ADD;


            endcase
        
        
        end
        2'b01: begin
            case (funct2)
                2'b00: alu_op = ADD; 
                2'b01: alu_op = SUB; 
                2'b10: alu_op = NOT;
                2'b11: alu_op = ADD;
                default: alu_op = ADD;
            endcase
        end
        

            
default: alu_op = ADD; 
        
    endcase
end

endmodule 
