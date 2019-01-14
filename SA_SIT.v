`include  "arch.v"

module SklanskyAdder_16(A, B, SUM, CO);
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  output CO;

  wire [15:0] P;
  wire [15:0] G;

  //calc P
  OR2 U1_0(.A(A[0]), .B(B[0]), .Y(P[0]));
  OR2 U1_1(.A(A[1]), .B(B[1]), .Y(P[1]));
  OR2 U1_2(.A(A[2]), .B(B[2]), .Y(P[2]));
  OR2 U1_3(.A(A[3]), .B(B[3]), .Y(P[3]));
  OR2 U1_4(.A(A[4]), .B(B[4]), .Y(P[4]));
  OR2 U1_5(.A(A[5]), .B(B[5]), .Y(P[5]));
  OR2 U1_6(.A(A[6]), .B(B[6]), .Y(P[6]));
  OR2 U1_7(.A(A[7]), .B(B[7]), .Y(P[7]));
  OR2 U1_8(.A(A[8]), .B(B[8]), .Y(P[8]));
  OR2 U1_9(.A(A[9]), .B(B[9]), .Y(P[9]));
  OR2 U1_10(.A(A[10]), .B(B[10]), .Y(P[10]));
  OR2 U1_11(.A(A[11]), .B(B[11]), .Y(P[11]));
  OR2 U1_12(.A(A[12]), .B(B[12]), .Y(P[12]));
  OR2 U1_13(.A(A[13]), .B(B[13]), .Y(P[13]));
  OR2 U1_14(.A(A[14]), .B(B[14]), .Y(P[14]));
  OR2 U1_15(.A(A[15]), .B(B[15]), .Y(P[15]));

  //calc G
  AN2 U2_0(.A(A[0]), .B(B[0]), .Y(G[0]));
  AN2 U2_1(.A(A[1]), .B(B[1]), .Y(G[1]));
  AN2 U2_2(.A(A[2]), .B(B[2]), .Y(G[2]));
  AN2 U2_3(.A(A[3]), .B(B[3]), .Y(G[3]));
  AN2 U2_4(.A(A[4]), .B(B[4]), .Y(G[4]));
  AN2 U2_5(.A(A[5]), .B(B[5]), .Y(G[5]));
  AN2 U2_6(.A(A[6]), .B(B[6]), .Y(G[6]));
  AN2 U2_7(.A(A[7]), .B(B[7]), .Y(G[7]));
  AN2 U2_8(.A(A[8]), .B(B[8]), .Y(G[8]));
  AN2 U2_9(.A(A[9]), .B(B[9]), .Y(G[9]));
  AN2 U2_10(.A(A[10]), .B(B[10]), .Y(G[10]));
  AN2 U2_11(.A(A[11]), .B(B[11]), .Y(G[11]));
  AN2 U2_12(.A(A[12]), .B(B[12]), .Y(G[12]));
  AN2 U2_13(.A(A[13]), .B(B[13]), .Y(G[13]));
  AN2 U2_14(.A(A[14]), .B(B[14]), .Y(G[14]));
  AN2 U2_15(.A(A[15]), .B(B[15]), .Y(G[15]));

  //layer 1 (2bit)
  PrefixBox B11(P[0], G[0], P[1], G[1], p11, g11);
  PrefixBox B31(P[2], G[2], P[3], G[3], p31, g31);
  PrefixBox B51(P[4], G[4], P[5], G[5], p51, g51);
  PrefixBox B71(P[6], G[6], P[7], G[7], p71, g71);
  PrefixBox B91(P[8], G[8], P[9], G[9], p91, g91);
  PrefixBox B111(P[10], G[10], P[11], G[11], p111, g111);
  PrefixBox B131(P[12], G[12], P[13], G[13], p131, g131);
  PrefixBox B151(P[14], G[14], P[15], G[15], p151, g151);

  //layer 2 (4bit)
  PrefixBox B22(p11, g11, P[2], G[2], p22, g22);
  PrefixBox B32(p11, g11, p31, g31, p32, g32);
  PrefixBox B62(p51, g51, P[6], G[6], p62, g62);
  PrefixBox B72(p51, g51, p71, g71,  p72, g72);
  PrefixBox B102(p91, g91, P[10], G[10], p102, g102);
  PrefixBox B112(p91, g91, p111, g111, p112, g112);
  PrefixBox B142(p131, g131, P[14], G[14], p142, g142);
  PrefixBox B152(p131, g131, p151, g151, p152, g152);

  //layer 3 (8bit)
  PrefixBox B43(p32, g32, P[4], G[4], p43, g43);
  PrefixBox B53(p32, g32, p51, g51, p53, g53);
  PrefixBox B63(p32, g32, p62, g62, p63, g63);
  PrefixBox B73(p32, g32, p72, g72, p73, g73);
  PrefixBox B123(p112, g112, P[12], G[12], p123, g123);
  PrefixBox B133(p112, g112, p131, g131, p133, g133);
  PrefixBox B143(p112, g112, p142, g142, p143, g143);
  PrefixBox B153(p112, g112, p152, g152, p153, g153);

  // layer 4 (16bit)
  PrefixBox B84(p73, g73, P[8], G[8], p84, g84);
  PrefixBox B94(p73, g73, p91, g91, p94, g94);
  PrefixBox B104(p73, g73, p102, g102, p104, g104);
  PrefixBox B114(p73, g73, p112, g112, p114, g114);
  PrefixBox B124(p73, g73, p123, g123, p124, g124);
  PrefixBox B134(p73, g73, p133, g133, p134, g134);
  PrefixBox B144(p73, g73, p143, g143, p144, g144);
  PrefixBox B154(p73, g73, p153, g153, p154, g154);


  //Add A + B + Carry
  XOR U3_0(.A(A[0]), .B(B[0]), .Y(SUM[0]));
  FA U3_1(.A(A[1]), .B(B[1]), .CI(G[0]), .CO(), .SO(SUM[1]));
  FA U3_2(.A(A[2]), .B(B[2]), .CI(g11), .CO(), .SO(SUM[2]));
  FA U3_3(.A(A[3]), .B(B[3]), .CI(g22), .CO(), .SO(SUM[3]));
  FA U3_4(.A(A[4]), .B(B[4]), .CI(g32), .CO(), .SO(SUM[4]));
  FA U3_5(.A(A[5]), .B(B[5]), .CI(g43), .CO(), .SO(SUM[5]));
  FA U3_6(.A(A[6]), .B(B[6]), .CI(g53), .CO(), .SO(SUM[6]));
  FA U3_7(.A(A[7]), .B(B[7]), .CI(g63), .CO(), .SO(SUM[7]));
  FA U3_8(.A(A[8]), .B(B[8]), .CI(g73), .CO(), .SO(SUM[8]));
  FA U3_9(.A(A[9]), .B(B[9]), .CI(g84), .CO(), .SO(SUM[9]));
  FA U3_10(.A(A[10]), .B(B[10]), .CI(g94), .CO(), .SO(SUM[10]));
  FA U3_11(.A(A[11]), .B(B[11]), .CI(g104), .CO(), .SO(SUM[11]));
  FA U3_12(.A(A[12]), .B(B[12]), .CI(g114), .CO(), .SO(SUM[12]));
  FA U3_13(.A(A[13]), .B(B[13]), .CI(g124), .CO(), .SO(SUM[13]));
  FA U3_14(.A(A[14]), .B(B[14]), .CI(g134), .CO(), .SO(SUM[14]));
  FA U3_15(.A(A[15]), .B(B[15]), .CI(g144), .CO(), .SO(SUM[15]));
  assign CO = g154;
endmodule

module PrefixBox(PR, GR, PL, GL, PO, GO);
  input PR, PL, GR, GL;
  output PO, GO;
  AN2 U0(.A(PL), .B(GR), .Y(item));
  AN2 U1(.A(PL), .B(PR), .Y(PO));
  OR2 U2(.A(GL), .B(item), .Y(GO));
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
  $monitor($time, " A=%b,B=%b, (SUM,CO)=(%b %b,%b),ANS=(%b %b,%b)", A, B, SUM[15:8], SUM[7:0],  CO, ANS[15:8], ANS[7:0], ANS[16]);
  $dumpfile("test.vcd");
  $dumpvars(0, Adder);
  A = 16'b0; B = 16'b0;

  #1000 A <= 16'h00ff;
  #100 B <= 16'h1;
  #100 B <= 16'h0;
  #100 B <= 16'h8000;
  #100 B <= 16'b1010101010101010;
  #100 B <= 16'b0101010101010101;
  #100 A <= 16'b00011111;
  #100 B <= 16'b00010000;
  #100 B <= 16'b1110100111100000;
  #100 A <= 16'b0011111001011110;
  #100 B <= 16'hffff;
  #2000 $finish;
  end

  //instadder Adder4(.a(A), .b(B), .ci(CI), .s(S), .co(CO));

endmodule
