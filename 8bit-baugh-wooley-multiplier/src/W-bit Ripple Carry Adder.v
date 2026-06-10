// W-bit Ripple Carry Adder
// -------------------------
module ripple_adder #(
parameter W = 16
)(
input wire [W-1:0] x,
input wire [W-1:0] y,
input wire cin,
output wire [W-1:0] s,
output wire cout
);
wire [W:0] c;
assign c[0] = cin;
genvar i;
generate
for (i = 0; i < W; i = i + 1) begin : FA_CHAIN
full_adder fa_i (
.a (x[i]),
.b (y[i]),
.cin (c[i]),
.sum (s[i]),
.cout(c[i+1])
);
end
endgenerate
assign cout = c[W];
endmodule
