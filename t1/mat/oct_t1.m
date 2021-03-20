
close all
clear all


#Dados dos componentes do circuito

R1 = 1.00359089673;
R2 = 2.04298963569;
R3 = 3.02503141993;
R4 = 4.05647775356;
R5 = 3.07781188185;
R6 = 2.01277040929;
R7 = 1.01993304256;
Va = 5.11402517827;
Id = 1.03896393154;
Kb = 7.23768458527;
Kc = 8.33526265782;

#Constante de proporcionalidade de i2 (i2 = C*i1)

C = (R3*Kb)/(1-Kb*R3)

#Forma matricial da equações de kirchhoff do circuito

A = [R1+R3*(1+C) + R4   R4    0;...
    R3*(C+1)+R2*C+R5*C    0    -1;...
    R4           (R4-Kc+R7+R6)   0]
 
          
B = [Va ; R5*Id ; 0]

#Solução da equação matricial


res = inv(A)*B

i1 = res(1)
i2 = i1 * C
i3 = res(2)
Vib = res(3)
i4 = Id

V_R = [R1*i1 R2*i2 R3*(i1+i2) R4*(i1+i3) R5*(i2-i4) R6*i3 R7*i3]
I_R = [i1 i2 i1+i2 i1+i3 i2-i4 i3 i3]

Vc = i3*Kc
Ib = V_R(3)*Kb



fid = fopen("Tabela-OCT.tex", "w");
fprintf(fid, "$V_{b}$ & %e \\\\ \\hline \n", Vib);
fprintf(fid, "$V_{c}$ & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$@I_{b}$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$@I_{c}$ & %e \\\\ \\hline \n", i3);
fprintf(fid, "$@I_{d}$ & %e \\\\ \\hline", Id);
fclose(fid);



