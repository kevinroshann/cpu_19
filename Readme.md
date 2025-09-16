OPCODES

0001 r types
0010 i types
0011 j types
0100 branch
0101 load
0110 store
0111 call
1000 ret
1001 encryption
1010 decryption
1011 fft


TYPES

0001 00
0010 01
0011 10
0100 11
0101 00
0110 00
0111 10
1000 10
1001 00
1010 00
1011 00


ALUTYPE

000 add
001 sub
010 mul
011 div
100 and
101 or
110 xor
111 and


funct2

00 ADD
01 SUB
10 NOT
11 ADD

INSTRUCNTION PARSER

RTYPE
rs1  =  [14:11];
rs2  =  [10:7];
rd   =  [6:3];
alu_type   =  [2:0];

ITYPE

rs1   =   [14:11];
funct2   =   [10:9];
rd   =   [6:3];

JTYPE

jump_addr=[10:0];

BRANCH

rs1=[14:11];
rs2=[10:7];
branch_addr=[7:0];


LOAD
rd=[14:11];
mem_addr=[7:0];

STORE

rs1=[14:11];
mem_addr=[7:0];


CALL
call_addr=[10:0];



ENCRY

rs1=[14:11];
mem_addr=[7:0];

DECRY

rs1=[14:11];
mem_addr=[7:0];



FFT

rs1=[14:11];
mem_addr=[7:0]; 


FILES
alu_control.v
branch.v
cpu_tb.v
cpu.v
data_mem.v
fft.v
instr_parser.v
Readme.md
shell.nix
subroutine.v
alu.v
control.v
encrdecr.v
instr_mem.v
pc.v
register_file.v
stack.v
type_decode.v


SAMPLE INSTRUCTION

19'b1010_0001_0000_0000001;  decrypt 
19'b1011_0001_0000_0000000;  fft
19'b0101_0001_0000_0000000;  load
19'b0101_0010_0000_0000001;  load
19'b0111_0000_0000_0010000;  call
19'b0110_0011_0000_0000010;  store
19'b0001_0100_0100_0101_000; addb


when running in eda playground uncomment
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

in design.sv


and 
// `include "design.sv"
in cpu_tb.sv


for runnning in vscode download iverilog and command
iverilog -g2012 -o cpu_tb_out *.sv
vvp cpu_tb_out


in eda playground use iverilog as simulator
https://www.edaplayground.com/x/QF9c


<img width="1274" height="227" alt="image" src="https://github.com/user-attachments/assets/66997ae9-8ae7-4162-9c2b-148aea7368c8" />
