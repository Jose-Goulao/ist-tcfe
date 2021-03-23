
close all
clear all


# Values from the Python script

R1 = 1.00359089673*1000;
R2 = 2.04298963569*1000;
R3 = 3.02503141993*1000;
R4 = 4.05647775356*1000;
R5 = 3.07781188185*1000;
R6 = 2.01277040929*1000;
R7 = 1.01993304256*1000;
Va = 5.11402517827;
Id = 1.03896393154/1000;
Kb = 7.23768458527/1000;
Kc = 8.33526265782*1000;

# Conductance

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;


# Matrix

A = [0 0 1 0 0 0 0 0 ;...
         G2 -(G1+G2+G3) G1 G3 0 0 0 0;...
         G2 -(Kb + G2) 0 Kb 0 0 0 0;...
         0 G3 0 -(G3 + G4 + G5) G5 0 0 1;...
         0 Kb 0 -(Kb + G5) G5 0 0 0;...
         0 0 0 0 0 G7 -G7 -1;...
         0 0 0 0 0 (G6+G7) -G7 0;...
         0 0 0 1 0 Kc*G6 -1 0]
 
          
B = [Va;0; 0; 0; Id; Id; 0; 0]

# Solution


res = inv(A)*B

n1 = res(1)
n2 = res(2)
n3 = res(3)
n4 = res(4)
n5 = res(5)
n6 = res(6)
n8 = res(7)

Ih1 = res(8)
Vc = n4 - n8
Ic = Vc/Kc

Vb = n4 - n2
Ib = Kb*Vb

# Create file

fid = fopen("Table_Nos-OCT.tex", "w");
fprintf(fid, "$V_{N1}$ & %e \\\\ \\hline \n", n1);
fprintf(fid, "$V_{N2}$ & %e \\\\ \\hline \n", n2);
fprintf(fid, "$V_{N3}$ & %e \\\\ \\hline \n", n3);
fprintf(fid, "$V_{N4}$ & %e \\\\ \\hline \n", n4);
fprintf(fid, "$V_{N5}$ & %e \\\\ \\hline \n", n5);
fprintf(fid, "$V_{N6}$ & %e \\\\ \\hline \n", n6);
fprintf(fid, "$V_{N8}$ & %e \\\\ \\hline \n", n8);

fprintf(fid, "$V_{b}$ & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & %e \\\\ \\hline \n", Vc);

fprintf(fid, "$@I_{b}$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$@I_{c}$ & %e \\\\ \\hline \n", Ic);
fprintf(fid, "$@I_{H1}$ & %e \\\\ \\hline", Ih1);
fclose(fid);


