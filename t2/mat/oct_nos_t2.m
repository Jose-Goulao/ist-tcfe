
close all
clear all

format long

#---------------------------------
# Values from the Python script
#---------------------------------

values = dlmread('data.txt');  

R1 = values(2,4)*1000;
R2 = values(3,3)*1000;
R3 = values(4,3)*1000;
R4 = values(5,3)*1000;
R5 = values(6,3)*1000;
R6 = values(7,3)*1000;
R7 = values(8,3)*1000;
Vs= values(9,3);
C1 = values(10,3)*0.000001;
Kb = values(11,3)*0.001;
Kd = values(12,3)*1000;

f1 = 1000;

#---------------------------------
# Conductance
#---------------------------------

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;

#############################################################
#------------------------------------------------------------
#			    matrix
#------------------------------------------------------------
#############################################################
#task1

A = [1 0 0 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 -1 0;...
    0 G3 0 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 0 0 0 0 0 1;...
    0 0 0 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 -Kb 0 0 0 0 -1 0];
    
B = [Vs;0;0;0;0;0;0;0;0;0];


res = A\B

Vn1 = res(1)
Vn2 = res(2)
Vn3 = res(3)
Vn5 = res(4)
Vn6 = res(5)
Vn7 = res(6)
Vn8 = res(7)

IH1 = res(8)
Ib = res(9)
Ic = res(10)


I1 = (Vn1 - Vn2)*G1
I2 = (Vn3-Vn2)*G2
I3 = (Vn2-Vn5)*G3
I4 = (Vn5)*G4
I5 = (Vn5-Vn6)*G5        %direção corrigida para a foto
Id = (Vn7)*G6
I7 = (Vn7-Vn8)*G7
IVs = I1

#Vb eVd


#------------------------------------------------------------
#task2

Vx = Vn6 - Vn8

A = [1 0 0 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 -1 0;...
    0 G3 0 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 1 0 -1 0 0 0;...
    0 0 0 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 -Kb 0 0 0 0 -1 0];
    
B = [0;0;0;0;0;0;0;Vx;0;0];    
    
    
res = A\B;

IH1_2 = res(8)
Ib_2 = res(9)
Ic_2 = res(10)



Vn1_2 = res(1)
Vn2_2 = res(2)
Vn3_2 = res(3)
Vn5_2 = res(4)
Vn6_2 = res(5)
Vn7_2 = res(6)
Vn8_2 = res(7)


I1_2 = (Vn1_2 - Vn2_2)*G1
I2_2 = (Vn3_2-Vn2_2)*G2
I3_2 = (Vn2_2-Vn5_2)*G3
I4_2 = (Vn5_2)*G4
I5_2 = (Vn5_2-Vn6_2)*G5        %direção corrigida para a foto
Id_2 = (Vn7_2)*G6
I7_2 = (Vn7_2-Vn8_2)*G7



Ic_i = res(10)
V6_i = res(5)

Req = abs(Vx/Ic_i)
t_c = Req*C1


#------------------------------------------------------------
#task3

t = [0:1e-6:20e-3];
V6_t_natural = V6_i * exp(-t/t_c);

hf=figure();
plot(t*1000, V6_t_natural, "g");

xlabel("t(ms)");
ylabel("V");




#------------------------------------------------------------
#task4

f=1e3;   %HZ
w=f*2*pi;
Z_c = -j/(w*C1);


A = [1 0 0 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 -1 0;...
    0 G3 0 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 -1/Z_c 0 1/Z_c 0 0 1;...
    0 0 0 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 -Kb 0 0 0 0 -1 0];
    
B = [1;0;0;0;0;0;0;0;0;0];

res = A\B;

Vn1_3 = abs(res(1))
Vn2_3 = abs(res(2))
Vn3_3 = abs(res(3))
Vn4_3 = 0
Vn5_3 = abs(res(4))
Vn6_3 = abs(res(5))
Vn7_3 = abs(res(6))
Vn8_3 = abs(res(7))





#------------------------------------------------------------
#task5

t_neg = [-0.005, 0];


V_t = sin(w*t);
V_t_neg = [Vs, Vs];
V_t = [V_t_neg V_t];

V6_t_forced = abs(res(5))*sin(w*t+arg(res(5)));
V6_t = V6_t_forced + V6_t_natural;
V6_t_neg = [Vx , Vx];
V6_t = [V6_t_neg V6_t];

t_5 = [t_neg t];

hf=figure();
plot(t_5*1000, V_t, "g");
hold on
plot(t_5*1000, V6_t, "g");

xlabel("t(ms)");
ylabel("V");  

#------------------------------------------------------------
#task6

l = 50;
f = logspace(-1, 6, l);
v6 = ones(l,1);
v6_ph = ones(l,1);


v6_8 = ones(l, 1);
v6_8_ph = ones(l,1);

p = 1;
for t = f

w=t*2*pi;
Z_c = -j/(w*C1);


A = [1 0 0 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 -1 0;...
    0 G3 0 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 -1/Z_c 0 1/Z_c 0 0 1;...
    0 0 0 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 -Kb 0 0 0 0 -1 0];
    
B = [1;0;0;0;0;0;0;0;0;0];

res = A\B;
v6(p) = abs(res(5));

v6_ph(p) = arg(res(5))*(180 / pi);

aux = res(5)-res(7);

v6_8(p) = abs(aux);

v6_8_ph(p) = arg(aux)*(180 / pi);
p = p + 1;
endfor

v6 = 20*log10(v6);
v6_8 = 20*log10(v6_8);


hf=figure();
%{
semilogx(f, v6, "color", "g");
hold on
semilogx(f, v6_ph, "color", "g", "linestyle", "--");
semilogx(f, v6_8, "color", "b");
semilogx(f, v6_8_ph, "color", "b" ,"linestyle", "--");

%}

[ax,hline1,hline2] = plotyy (f, v6, f, v6_ph, @semilogx)
hold on 
set(hline1 ,'Color',"g");
set(hline2 ,'Color',"g", "linestyle", "--");
%set(ax(1),'Color',"k");


[ax,hline1,hline2] = plotyy (f, v6_8, f, v6_8_ph, @semilogx); 
set(hline1 ,'Color',"b");
set(hline2 ,'Color',"b", "linestyle", "--");
set(ax,{'ycolor'},{'k';'k'})



ylim_v= [min([v6; v6_8]), max([v6; v6_8])]
ylim_ph = [min([v6_ph; v6_8_ph]), max([v6_ph; v6_8_ph])]

ylim_v = ylim_v + [ylim_v(1)*0.1 ,-ylim_v(1)*0.1]
ylim_ph = ylim_ph + [ylim_ph(1)*0.1 ,-ylim_ph(1)*0.1]


set(ax(1), 'YLim', ylim_v);
set(ax(2), 'YLim', ylim_ph);


xlabel("Frequency(HZ)")
ylabel(ax(1), 'Magnitude (Db)');
ylabel(ax(2), 'Phase angle (º)');

#############################################################
#------------------------------------------------------------
#			   oct tbls
#------------------------------------------------------------
#############################################################


file = fopen("Tbl_oct-1.tex", "w");
	fprintf(file, "$V_{N1}$ & %e \\\\ \\hline \n", Vn1);
	fprintf(file, "$V_{N2}$ & %e \\\\ \\hline \n", Vn2);
	fprintf(file, "$V_{N3}$ & %e \\\\ \\hline \n", Vn3);
	fprintf(file, "$V_{N5}$ & %e \\\\ \\hline \n", Vn5);
	fprintf(file, "$V_{N6}$ & %e \\\\ \\hline \n", Vn6);
	fprintf(file, "$V_{N7}$ & %e \\\\ \\hline \n", Vn7);
	fprintf(file, "$V_{N8}$ & %e \\\\ \\hline \n", Vn8);
	
	#fprintf(file, "$V_{b}$ & %e \\\\ \\hline \n", Vb);
	#fprintf(file, "$V_{d}$ & %e \\\\ \\hline \n", Vd);

	fprintf(file, "$@I_{b}$ & %e \\\\ \\hline \n", Ib);
	fprintf(file, "$@I_{c}$ & %e \\\\ \\hline \n", Ic);
	fprintf(file, "$@I_{R1}$ & %e \\\\ \\hline \n", I1);
	fprintf(file, "$@I_{R2}$ & %e \\\\ \\hline \n", I2);
	fprintf(file, "$@I_{R3}$ & %e \\\\ \\hline \n", I3);
	fprintf(file, "$@I_{R4}$ & %e \\\\ \\hline \n", I4);
	fprintf(file, "$@I_{R5}$ & %e \\\\ \\hline \n", I5);
	fprintf(file, "$@I_{d}$ & %e \\\\ \\hline \n", Id);
	fprintf(file, "$@I_{R6}$ & %e \\\\ \\hline \n", I7);

fclose(file);

#------------------------------------------------------------

file = fopen("Tbl_oct-2.tex", "w");
	fprintf(file, "$V_{N1}$ & %e \\\\ \\hline \n", Vn1_2);
	fprintf(file, "$V_{N2}$ & %e \\\\ \\hline \n", Vn2_2);
	fprintf(file, "$V_{N3}$ & %e \\\\ \\hline \n", Vn3_2);
	fprintf(file, "$V_{N5}$ & %e \\\\ \\hline \n", Vn5_2);
	fprintf(file, "$V_{N6}$ & %e \\\\ \\hline \n", Vn6_2);
	fprintf(file, "$V_{N7}$ & %e \\\\ \\hline \n", Vn7_2);
	fprintf(file, "$V_{N8}$ & %e \\\\ \\hline \n", Vn8_2);

	fprintf(file, "$@I_{b}$ & %e \\\\ \\hline \n", Ib_2);
	fprintf(file, "$@I_{d}$ & %e \\\\ \\hline \n", Id_2);
	fprintf(file, "$@I_{H1}$ & %e \\\\ \\hline \n", IH1_2);
	
	fprintf(file, "$@V_{x}$ & %e \\\\ \\hline \n", Vx);
	fprintf(file, "$@I_{x}$ & %e \\\\ \\hline \n", Ic_i);
	fprintf(file, "$@R_{eq}$ & %e \\\\ \\hline \n", Req);
	fprintf(file, "$@\\tau$ & %e \\\\ \\hline \n", t_c);
	

	
fclose(file);

#------------------------------------------------------------

file = fopen("Tbl_oct-3.tex", "w");
	fprintf(file, "$V_{N1}$ & %e \\\\ \\hline \n", Vn1_3);
	fprintf(file, "$V_{N2}$ & %e \\\\ \\hline \n", Vn2_3);
	fprintf(file, "$V_{N3}$ & %e \\\\ \\hline \n", Vn3_3);
	fprintf(file, "$V_{N5}$ & %e \\\\ \\hline \n", Vn5_3);
	fprintf(file, "$V_{N6}$ & %e \\\\ \\hline \n", Vn6_3);
	fprintf(file, "$V_{N7}$ & %e \\\\ \\hline \n", Vn7_3);
	fprintf(file, "$V_{N8}$ & %e \\\\ \\hline \n", Vn8_3);

fclose(file);

#############################################################
#------------------------------------------------------------
#			   ngs files
#------------------------------------------------------------
#############################################################
#
#file = fopen("given_vls_m.tex", "w");
#
#	fprintf(file, "$R1$ & %f \\\\ \\hline \n", R1/1000);
#	fprintf(file, "$R2$ & %f \\\\ \\hline \n", R2);
#	fprintf(file, "$R3$ & %f \\\\ \\hline \n", R3);	
#	fprintf(file, "$R4$ & %f \\\\ \\hline \n", R4);
#	fprintf(file, "$R5$ & %f \\\\ \\hline \n", R5);
#	fprintf(file, "$R6$ & %f \\\\ \\hline \n", R6);
#	fprintf(file, "$R7$ & %f \\\\ \\hline \n", R7);
#	fprintf(file, "$V_s$ & %f \\\\ \\hline \n", Vs);
#	fprintf(file, "$C$ & %f \\\\ \\hline \n", C1*1000000);
#	fprintf(file, "$K_b$ & %f \\\\ \\hline\n", Kb);
#	fprintf(file, "$K_d$ & %f \\\\ \\hline \n", Kd);
#	
#fclose(file);
#
#------------------------------------------------------------

file = fopen("Dados_ngs-1.txt", "w");

	fprintf(file, "R1	N2	N1	%f \n", R1);
	fprintf(file, "R2	N3	N2	%f \n", R2);
	fprintf(file, "R3 	N5	N2	%f \n", R3);	
	fprintf(file, "R4	0	N5	%f \n", R4);
	fprintf(file, "R5	N5	N6	%f \n", R5);
	fprintf(file, "R6	0	N7	%f \n", R6);
	fprintf(file, "R7	N8	N7.	%f \n", R7);

	fprintf(file, "Vs	N1	0	%f \n", Vs);
	fprintf(file, "C	N8	N6	%f \n", C1);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%f \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%f \n", Kd);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-2.txt", "w");

	fprintf(file, "R1	N2	N1	%f \n", R1);
	fprintf(file, "R2	N3	N2	%f \n", R2);
	fprintf(file, "R3 	N5	N2	%f \n", R3);	
	fprintf(file, "R4	0	N5	%f \n", R4);
	fprintf(file, "R5	N5	N6	%f \n", R5);
	fprintf(file, "R6	0	N7	%f \n", R6);
	fprintf(file, "R7	N8	N7.	%f \n", R7);

	fprintf(file, "Vs	N1	0	0 \n");
	fprintf(file, "Vx	N6	N8	%f \n", Vx);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%f \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%f \n", Kd);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-3.txt", "w");

	fprintf(file, "R1	N2	N1	%f \n", R1);
	fprintf(file, "R2	N3	N2	%f \n", R2);
	fprintf(file, "R3 	N5	N2	%f \n", R3);	
	fprintf(file, "R4	0	N5	%f \n", R4);
	fprintf(file, "R5	N5	N6	%f \n", R5);
	fprintf(file, "R6	0	N7	%f \n", R6);
	fprintf(file, "R7	N8	N7.	%f \n", R7);

	fprintf(file, "Vs	N1	0	0  AC	1.0\n");
	fprintf(file, "C	N6	N8	%f \n", C1);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%f \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%f \n", Kd);
	
	fprintf(file, ".ic v(n6)=%f v(n8)=0V\n", Vx);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-4.txt", "w");

	fprintf(file, "R1	N2	N1	%f \n", R1);
	fprintf(file, "R2	N3	N2	%f \n", R2);
	fprintf(file, "R3 	N5	N2	%f \n", R3);	
	fprintf(file, "R4	0	N5	%f \n", R4);
	fprintf(file, "R5	N5	N6	%f \n", R5);
	fprintf(file, "R6	0	N7	%f \n", R6);
	fprintf(file, "R7	N8	N7.	%f \n", R7);

	fprintf(file, "Vs	N1	0	0.0	AC	1.0	sin(0 1 %f) \n", f1);
	fprintf(file, "C	N8	N6	%f \n", C1);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%f \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%f \n", Kd);
	
	fprintf(file, ".ic v(n6)=%f v(n8)=0V\n", Vx);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-5.txt", "w");

	fprintf(file, "R1	N2	N1	%f \n", R1);
	fprintf(file, "R2	N3	N2	%f \n", R2);
	fprintf(file, "R3 	N5	N2	%f \n", R3);	
	fprintf(file, "R4	0	N5	%f \n", R4);
	fprintf(file, "R5	N5	N6	%f \n", R5);
	fprintf(file, "R6	0	N7	%f \n", R6);
	fprintf(file, "R7	N8	N7.	%f \n", R7);

	fprintf(file, "Vs	N1	0	0.0	AC	1.0	sin(0 1 %f) \n", f1);
	fprintf(file, "C	N8	N6	%f \n", C1);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%f \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%f \n", Kd);
	
fclose(file);


