

module SLU(
    input logic [15:0] a,
    input logic [3:0] shift,
    output logic [15:0] out
);

    MUX16 bit0 ({{15{1'b0}}, a[0]}, shift, out[0]);
    MUX16 bit1 ({{14{1'b0}}, a[0], a[1]}, shift, out[1]);
    MUX16 bit2 ({{13{1'b0}}, a[0], a[1], a[2]}, shift, out[2]);
    MUX16 bit3 ({{12{1'b0}}, a[0], a[1], a[2], a[3]}, shift, out[3]);
    MUX16 bit4 ({{11{1'b0}}, a[0], a[1], a[2], a[3], a[4]}, shift, out[4]);
    MUX16 bit5 ({{10{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5]}, shift, out[5]);
    MUX16 bit6 ({{9{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6]}, shift, out[6]);
    MUX16 bit7 ({{8{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]}, shift, out[7]);
    MUX16 bit8 ({{7{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]}, shift, out[8]);
    MUX16 bit9 ({{6{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]}, shift, out[9]);
    MUX16 bit10 ({{5{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]}, shift, out[10]);
    MUX16 bit11 ({{4{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]}, shift, out[11]);
    MUX16 bit12 ({{3{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]}, shift, out[12]);
    MUX16 bit13 ({{2{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]}, shift, out[13]);
    MUX16 bit14 ({{1{1'b0}}, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]}, shift, out[14]);
    MUX16 bit15 ({ a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]}, shift, out[15]);

endmodule