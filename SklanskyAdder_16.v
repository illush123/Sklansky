`include  "arch.v"

module SklanskyAdder_16(A, B, SUM, CO);
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  output CO;

  wire [15:0] G;
  wire [15:0] P;

  wire [15:0] PO;
  wire [15:0] GO;

  genvar i;

  parameter SIZE = 16;
  //calc P,G from A,B
  generate
  for(i=0;i<SIZE;i=i+1) begin
    OR2 U1_1(.A(A[i]), .B(B[i]), .Y(P[i]));
    AN2 U1_2(.A(A[i]), .B(B[i]), .Y(G[i]));
  end
  endgenerate

  //2bit_loop
  generate
  for(i=0;i<SIZE;i=i+2) begin
    PrefixBox B11(P[i], G[i], P[i+1], G[i+1], PO[i+1], GO[i+1]);//1,3,5,9,11,13,15
  end
  endgenerate

  //4bit_loop
  generate
  for(i=2;i<SIZE;i=i+4) begin
  PrefixBox B21(PO[i-1], GO[i-1], P[i], G[i], PO[i], GO[i]); //2,6,10,14
  PrefixBox B22(PO[i-1], GO[i-1], PO[i+1], GO[i+1], PO[i+1], GO[i+1]);//3,7,11,15
  end
  endgenerate

  //8bit_loop
  generate
  for(i=4;i<SIZE;i=i+8) begin
  PrefixBox B30(P[i], G[i], PO[i-1], GO[i-1], PO[i], GO[i]);
  PrefixBox B31(PO[i+1], G[i+1], PO[i-1], GO[i-1], PO[i+1], GO[i+1]);
  PrefixBox B32(PO[i+2], G[i+2], PO[i-1], GO[i-1], PO[i+2], GO[i+2]);
  PrefixBox B33(PO[i+3], G[i+3], PO[i-1], GO[i-1], PO[i+3], GO[i+3]);
  end
  endgenerate

  //16bit_loop(once)
  generate
  for(i=8;i<SIZE;i=i+8) begin
    PrefixBox B40(P[i], G[i], PO[i-1], GO[i-1], PO[i], GO[i]);
    PrefixBox B41(PO[i+1], GO[i+1], PO[i-1], GO[i-1], PO[i+1], GO[i+1]);
    PrefixBox B42(PO[i+2], GO[i+2], PO[i-1], GO[i-1], PO[i+2], GO[i+2]);
    PrefixBox B43(PO[i+3], GO[i+3], PO[i-1], GO[i-1], PO[i+3], GO[i+3]);
    PrefixBox B44(PO[i+4], GO[i+4], PO[i-1], GO[i-1], PO[i+4], GO[i+4]);
    PrefixBox B45(PO[i+5], GO[i+5], PO[i-1], GO[i-1], PO[i+5], GO[i+5]);
    PrefixBox B46(PO[i+6], GO[i+6], PO[i-1], GO[i-1], PO[i+6], GO[i+6]);
    PrefixBox B47(PO[i+7], GO[i+7], PO[i-1], GO[i-1], PO[i+7], GO[i+7]);
  end
  endgenerate

  wire CI;
  assign CI = 0;
  FA U1_0(.A(A[0]), .B(B[0]), .CI(CI), .CO(), .SO(SUM[0]));
  FA U1_1(.A(A[1]), .B(B[1]), .CI(GO[0]), .CO(), .SO(SUM[1]));
  FA U1_2(.A(A[2]), .B(B[2]), .CI(GO[1]), .CO(), .SO(SUM[2]));
  FA U1_3(.A(A[3]), .B(B[3]), .CI(GO[2]), .CO(), .SO(SUM[3]));
  FA U1_4(.A(A[4]), .B(B[0]), .CI(GO[3]), .CO(), .SO(SUM[4]));
  FA U1_5(.A(A[5]), .B(B[1]), .CI(GO[4]), .CO(), .SO(SUM[5]));
  FA U1_6(.A(A[6]), .B(B[2]), .CI(GO[5]), .CO(), .SO(SUM[6]));
  FA U1_7(.A(A[7]), .B(B[3]), .CI(GO[6]), .CO(), .SO(SUM[7]));
  FA U1_8(.A(A[8]), .B(B[0]), .CI(GO[7]), .CO(), .SO(SUM[8]));
  FA U1_9(.A(A[9]), .B(B[1]), .CI(GO[8]), .CO(), .SO(SUM[9]));
  FA U1_10(.A(A[10]), .B(B[2]), .CI(GO[9]), .CO(), .SO(SUM[10]));
  FA U1_11(.A(A[11]), .B(B[3]), .CI(GO[10]), .CO(), .SO(SUM[11]));
  FA U1_12(.A(A[12]), .B(B[0]), .CI(GO[11]), .CO(), .SO(SUM[12]));
  FA U1_13(.A(A[13]), .B(B[1]), .CI(GO[12]), .CO(), .SO(SUM[13]));
  FA U1_14(.A(A[14]), .B(B[2]), .CI(GO[13]), .CO(), .SO(SUM[14]));
  FA U1_15(.A(A[15]), .B(B[3]), .CI(GO[14]), .CO(), .SO(SUM[15]));
  assign CO = G[15];
endmodule

module PrefixBox(PR, GR, PL, GL, PO, GO);
  input PR, PL, GR, GL;
  output PO, GO;
  AN2 U1(.A(PR), .B(PL), .Y(PO));
  OR2 U2(.A(GR), .B(GL), .Y(GO));
endmodule

module test_adder;
  reg [15:0] A;
  reg [15:0] B;
  wire [15:0] SUM;
  wire CO;
  wire [16:0] ANS;
  SklanskyAdder_16 Adder(.A(A), .B(B), .SUM(SUM), .CO(CO));

  assign ANS = A + B;

  initial begin
  $monitor($time, " A=%b,B=%b, (SUM,CO)=(%b,%b),ANS=(%b,%b)", A, B, SUM, CO, ANS[15:0], ANS[16]);

  A = 16'b0; B = 16'b0;

  #1000 A <= 16'hffff;
  #1000 B<= 16'h1;
  #1000 B<= 16'h0;
  #1000 B<= 16'hffff;
  #2000 $finish;
  end
  /*initial begin
    $shm_open("waves.shm");
    $shm_probe("AS");
  end
*/
  //instadder Adder4(.a(A), .b(B), .ci(CI), .s(S), .co(CO));

endmodule
