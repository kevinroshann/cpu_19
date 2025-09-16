`timescale 1ns/1ps
module type_decode (
    input wire [3:0] opcode,
    output reg [1:0] types
);

always @(*) begin
    case (opcode)
        4'b0001: types = 2'b00;  //rtype
        4'b0101: types = 2'b00;  //ld
        4'b0110: types = 2'b00;  //store
4'b1001: types=2'b00;
4'b1010: types=2'b00;
4'b1011: types=2'b00;


        4'b0010: types = 2'b01; //I

        4'b0011: types=2'b10; //J
        4'b0111: types=2'b10; //call
        4'b1000: types=2'b10; //ret

        4'b0100:types=2'b11; //btype
        
        default: types = 2'b00; 
    endcase
end

endmodule //type_decode
