module tb_bw_mul8;
reg [7:0] a;
reg [7:0] b;
wire [15:0] p;
// Signed reference variables
reg signed [7:0] as, bs;
reg signed [15:0] pref;
integer i, j;
integer errors;
// DUT
bw_mul8 DUT (
.a(a),
.b(b),
.p(p)
);
initial begin
errors = 0;
$display("Starting Baugh-Wooley Multiplier Test...");
// Exhaustive Testing
for(i = -128; i <= 127; i = i + 1) begin
for(j = -128; j <= 127; j = j + 1) begin
as = i;
bs = j;
a = as;
b = bs;
#1; // allow combinational delay
// Reference multiplication
pref = as * bs;
// Compare DUT vs reference
if($signed(p) !== pref) begin
$display("ERROR -> a=%0d b=%0d DUT=%0d REF=%0d",
as, bs, $signed(p), pref);
errors = errors + 1;
end
39
end
end
// Final Result
if(errors == 0)
$display(" PASS : All test cases matched");
else
$display(" FAIL : %0d mismatches found", errors);
$finish;
end
Endmodule