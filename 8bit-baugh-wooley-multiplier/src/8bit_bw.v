// 8x8 Baugh-Wooley Signed Multiplier
// --------------------------------------------------
module bw_mul8 (
input wire [7:0] a,
input wire [7:0] b,
output wire [15:0] p
);
// Raw Partial Products
wire r[7:0][7:0];
wire pp[7:0][7:0];
genvar i,j;
// Generate AND partial products
generate
for(i=0;i<8;i=i+1) begin
for(j=0;j<8;j=j+1) begin
assign r[i][j] = a[i] & b[j];
end
end
endgenerate
// -----------------------------
// Baugh-Wooley Inversion Rule
// invert when (i==7 XOR j==7)
// -----------------------------
generate
for(i=0;i<8;i=i+1) begin
for(j=0;j<8;j=j+1) begin
if((i==7 && j!=7) || (j==7 && i!=7))
assign pp[i][j] = ~r[i][j];
else
assign pp[i][j] = r[i][j];
end
end
endgenerate
// -----------------------------
// Shifted Rows
// -----------------------------
wire [15:0] row[7:0];
generate
for(j=0;j<8;j=j+1) begin
for(i=0;i<16;i=i+1) begin
if(i>=j && i<(j+8))
assign row[j][i] = pp[i-j][j];
else
assign row[j][i] = 1'b0;
end
end
endgenerate
// -----------------------------
// Baugh-Wooley Bias
// -----------------------------
wire [15:0] bias = 16'b1000000100000000;
// -----------------------------
// Add All Rows
// -----------------------------
wire [15:0] s1,s2,s3,s4,s5,s6,s7,s8;
wire c1,c2,c3,c4,c5,c6,c7,c8;
ripple_adder #(16) A1(row[0],row[1],0,s1,c1);
ripple_adder #(16) A2(s1,row[2],0,s2,c2);
ripple_adder #(16) A3(s2,row[3],0,s3,c3);
ripple_adder #(16) A4(s3,row[4],0,s4,c4);
ripple_adder #(16) A5(s4,row[5],0,s5,c5);
ripple_adder #(16) A6(s5,row[6],0,s6,c6);
ripple_adder #(16) A7(s6,row[7],0,s7,c7);
ripple_adder #(16) A8(s7,bias ,0,s8,c8);
assign p = s8;
endmodule