clear all
close all
clc


R1 = 10e3;
R2 = 1e3;
R3 = 100e3;
R4 = 1e3;

C1 = 220e-9;
C2 = 1e-6;

n = 1000;

f = logspace(1, 8, n);
G = zeros(1,n);
G1 = zeros(1,n);
G2 = zeros(1,n);
G3 = zeros(1,n);
imp1 = zeros(1,n);
imp2 = zeros(1,n);
for i = 1:n;
  gain = 1;
  w = 2*pi*f(i);
  imp_c1 = 1/(C1*w);
  imp_c2 = 1/(C2*w);
  
  imp1(i) = R1/(R1 + imp_c1);
  imp2(i) = imp_c2/(imp_c2+R4);
  
  
  gain = gain * R1/(R1 + imp_c1);   %voltage divider/filter
  G1(i) = gain;
  gain = gain * (1 + R3/R2);     %non inverting amp
  %G2(i) = gain;
  %gain = gain * imp_c2/(imp_c2+R4);
  
  G(i) = gain;
endfor

G = 20*log10(G);
hf=figure();
semilogx(f,G);

hold on;
%plot(f, 40*ones(1,n));
%plot(f, G1);
%plot(f, G2);
%plot(f, imp1);
%plot(f, imp2);


xlabel("Frequência (Hz)");
ylabel("Ganho (dB)");

print(hf, "band_pass.eps", "-depsc")


