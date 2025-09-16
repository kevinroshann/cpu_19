`timescale 1ns/1ps
module encrdecr (
    input wire [18:0] a,
    input wire encr_en,
    input wire decr_en,
    output reg [18:0] result
);


parameter [18:0] key = 19'h1A2B3;

always @(*) begin
    result = 19'd0; 
    
    if (encr_en) begin
    
    
        result = a ^ key;
    
    
    end


    else if (decr_en) begin
    
        result = a ^ key; 
    
    
    
    end
    
end

endmodule
