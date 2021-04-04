
close all
clear all

#format short e
#pkg load symbolic
#pkg load control
#pkg load signal

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

f = 1000;

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
#			files' creation
#------------------------------------------------------------
#############################################################

file = fopen("given_vls_m.tex", "w");

	fprintf(file, "$R1$ & %d \\\\ \\hline \n", R1);
	fprintf(file, "$R2$ & %d \\\\ \\hline \n", R2);
	fprintf(file, "$R3$ & %d \\\\ \\hline \n", R3);	
	fprintf(file, "$R4$ & %d \\\\ \\hline \n", R4);
	fprintf(file, "$R5$ & %d \\\\ \\hline \n", R5);
	fprintf(file, "$R6$ & %d \\\\ \\hline \n", R6);
	fprintf(file, "$R7$ & %d \\\\ \\hline \n", R7);
	fprintf(file, "$V_s$ & %d \\\\ \\hline \n", Vs);
	fprintf(file, "$C$ & %d \\\\ \\hline \n", C1);
	fprintf(file, "$K_b$ & %d \\\\ \\hline\n", Kb);
	fprintf(file, "$K_d$ & %d \\\\ \\hline \n", Kd);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-1.txt", "w");

	fprintf(file, "R1	N2	N1	%d \n", R1);
	fprintf(file, "R2	N3	N2	%d \n", R2);
	fprintf(file, "R3 	N5	N2	%d \n", R3);	
	fprintf(file, "R4	0	N5	%d \n", R4);
	fprintf(file, "R5	N5	N6	%d \n", R5);
	fprintf(file, "R6	0	N7	%d \n", R6);
	fprintf(file, "R7	N8	N7.	%d \n", R7);

	fprintf(file, "Vs	N1	0	%d \n", Vs);
	fprintf(file, "C	N8	N6	%d \n", C1);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%d \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%d \n", Kd);
	
fclose(file);

#------------------------------------------------------------

file = fopen("Dados_ngs-1.txt", "w");

	fprintf(file, "R1	N2	N1	%d \n", R1);
	fprintf(file, "R2	N3	N2	%d \n", R2);
	fprintf(file, "R3 	N5	N2	%d \n", R3);	
	fprintf(file, "R4	0	N5	%d \n", R4);
	fprintf(file, "R5	N5	N6	%d \n", R5);
	fprintf(file, "R6	0	N7	%d \n", R6);
	fprintf(file, "R7	N8	N7.	%d \n", R7);

	fprintf(file, "Vs	N1	0	%d \n", Vs);
	#fprintf(file, "Vx	N8	N6	%d \n", Vx);

	fprintf(file, "Vaux	N7	N7.	0 \n");

	fprintf(file, "G1	N6	N3	N2	N5	%d \n", Kb);
	fprintf(file, "H1	N5	N8	Vaux	%d \n", Kd);
	
fclose(file);




