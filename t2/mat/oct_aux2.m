
close all
clear all

format long

dados = dlmread('data.txt');  

R1 = dados(2,4)*1000;
R2 = dados(3,3)*1000;
R3 = dados(4,3)*1000;
R4 = dados(5,3)*1000;
R5 = dados(6,3)*1000;
R6 = dados(7,3)*1000;
R7 = dados(8,3)*1000;
Vs = dados(9,3);
C1 = dados(10,3)*0.000001;
Kb = dados(11,3)*0.001;
Kd = dados(12,3)*1000;


dado = dlmread('op_tab.tex');  

Vx = dado(22,3)

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



