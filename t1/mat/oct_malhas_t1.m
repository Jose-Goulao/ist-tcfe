
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



G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;


#Forma matricial da equações de kirchhoff

A = [(R1 + R3 + R4) -R3 R4 0 0 0 0 0 ;...
         0 1 0 0 1 0 0 0;...
         R4 0 (R4+R7+R6) 0 0 0 0 1;...
         0 0 1 0 0 1 0 0;...
         0 0 0 1 0 0 0 0;...
         0 0 0 0 1 0 -Kb 0;...
         R3 -R3 0 0 0 0 -1 0;...
         0 0 0 1 0 -Kc 0 1]
 
          
B = [Va;0; 0; 0; -Id; 0; 0; 0]

#Solução da equação matricial


res = inv(A)*B

i1 = res(1)
i2 = res(2)
i3 = res(3)
i4 = res(4)

Ib = res(5)
Ic = res(6)

Vb = res(7)
Vc = res(8)

fid = fopen("Table_Malhas-OCT.tex", "w");
fprintf(fid, "$@I_{1}$ & %e \\\\ \\hline \n", i1);
fprintf(fid, "$@I_{2}$ & %e \\\\ \\hline \n", i2);
fprintf(fid, "$@I_{3}$ & %e \\\\ \\hline \n", i3);
fprintf(fid, "$@I_{4}$ & %e \\\\ \\hline \n", i4);


fprintf(fid, "$V_{b}$ & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_{c}$ & %e \\\\ \\hline \n", Vc);

fprintf(fid, "$@I_{b}$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$@I_{c}$ & %e \\\\ \\hline \n", Ic);
fclose(fid);


