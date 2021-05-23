%gain stage
clear all
clc
close all


VT=25e-3;
BFN=178.7;
VAFN=69.7;
RE1=200.0242;
RC1=384.0001;
RB1=85000;
RB2=20000;
VBEON=0.7;
VCC=12;
RS=100;
C_b = 5e-3;
C_i = 54.1102e-6;


RB=1/(1/RB1+1/RB2);
VEQ=RB2/(RB1+RB2)*VCC;
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1=BFN*IB1;
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1;
VCE=VO1-VE1


gm1=IC1/VT;
rpi1=BFN/gm1;
ro1=VAFN/IC1;

RSB=RB*RS/(RB+RS);

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=0;
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=200.0242;
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)));
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ) ;
ZO1 = 1/(1/ZX+1/RC1)

n = 70;
f = logspace(1, 8, n);
gain_f = zeros(1,n);

for i = 1:n
  w = f(i)*2*pi;
  RE1_C = 1/sqrt((1/RE1)**2+(C_b*w)**2);
  RS_C= sqrt(RS**2 + 1/((w*C_i)**2));
  RSB_C=RB*RS_C/(RB+RS_C);
  gain_f(i) = RSB_C/RS_C * RC1*(RE1_C-gm1*rpi1*ro1)/((ro1+RC1+RE1_C)*(RSB_C+rpi1+RE1_C)+gm1*RE1_C*ro1*rpi1 - RE1_C^2);
endfor
gain_f_db = 20*log10(abs(gain_f));



%{
RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)
%}
%ouput stage
BFP = 227.3;
VAFP = 37.2;
RE2 = 15;
VEBON = 0.7;
VI2 = VO1;
IE2 = (VCC-VEBON-VI2)/RE2;
IC2 = BFP/(BFP+1)*IE2;
VO2 = VCC - RE2*IE2

gm2 = IC2/VT;
go2 = IC2/VAFP;
gpi2 = gm2/BFP;
ge2 = 1/RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2);
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


%total
gB = 1/(1/gpi2+ZO1);
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1;
AV_DB = 20*log10(abs(AV));
ZI=ZI1;
ZO=1/(go2+gm2/gpi2*gB+ge2+gB);

gain_final = gain_f*(gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB);

gain_final_db = 20*log10(abs(gain_final));


hf=figure();
semilogx(f, gain_final_db);

title("Frequency Response Vo/Vi")
xlabel("Frequency (Hz)")
ylabel("Gain (dB)")


file = fopen("Tbl_oct-imp.tex", "w");
	fprintf(file, "$Z1_{In}$ & %e \\\\ \\hline \n", ZI1);
	fprintf(file, "$Z1_{Out}$ & %e \\\\ \\hline \n", ZO1);
	fprintf(file, "$Z2_{In}$ & %e \\\\ \\hline \n", ZI2);
	fprintf(file, "$Z2_{Out}$ & %e \\\\ \\hline \n", ZO2);
	fprintf(file, "$Zt_{Out}$ & %e \\\\ \\hline \n", ZO);

fclose(file);

file = fopen("Tbl_oct-op.tex", "w");
	fprintf(file, "$Ve$ & %e \\\\ \\hline \n", VE1);
	fprintf(file, "$Vc$ & %e \\\\ \\hline \n", VO1);
	fprintf(file, "$Vce$ & %e \\\\ \\hline \n", VCE);
	fprintf(file, "$Vec2$ & %e \\\\ \\hline \n", VO2);

fclose(file);
