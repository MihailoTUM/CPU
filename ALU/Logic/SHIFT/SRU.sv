

module SRU(
    input logic [15:0] a,
    input logic [3:0] shift,
    output logic [15:0] out
);

    MUX16 bit0(a, shift, out[0]);
    MUX16 bit1({1'b0, a[15:1]}, shift, out[1]);
    MUX16 bit2({{2{1'b0}}, a[15:2]}, shift, out[2]);
    MUX16 bit3({{3{1'b0}}, a[15:3]}, shift, out[3]);
    MUX16 bit4({{4{1'b0}}, a[15:4]}, shift, out[4]);
    MUX16 bit5({{5{1'b0}}, a[15:5]}, shift, out[5]);
    MUX16 bit6({{6{1'b0}}, a[15:6]}, shift, out[6]);
    MUX16 bit7({{7{1'b0}}, a[15:7]}, shift, out[7]);
    MUX16 bit8({{8{1'b0}}, a[15:8]}, shift, out[8]);
    MUX16 bit9({{9{1'b0}}, a[15:9]}, shift, out[9]);
    MUX16 bit10({{10{1'b0}}, a[15:10]}, shift, out[10]);
    MUX16 bit11({{11{1'b0}}, a[15:11]}, shift, out[11]);
    MUX16 bit12({{12{1'b0}}, a[15:12]}, shift, out[12]);
    MUX16 bit13({{13{1'b0}}, a[15:13]}, shift, out[13]);
    MUX16 bit14({{14{1'b0}}, a[15:14]}, shift, out[14]);
    MUX16 bit15({{15{1'b0}}, a[15]}, shift, out[15]);
    

endmodule