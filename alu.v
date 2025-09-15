module alu (
    input wire [18:0] a,
    input wire [18:0] b,
    input wire [2:0] alu_op,
    output reg zero,
    output reg [18:0] result
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
    case (alu_op)
        
        ADD: result=a+b;
        SUB: result=a-b;
        MUL: result=a*b;
        DIV: result= (b==0) ?19'd0:(a/b);
        AND: result=a&b;
        OR: result =a|b;
        XOR: result =a^b;
        NOT: result=~a;

        default: result = 19'd0;

    endcase
    zero=(result==19'd0);
end


endmodule //alu