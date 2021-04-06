
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

f1 = 1000;

#------------------------------------------------------------

dado = dlmread('_tab.tex');  

Vn6 = dado(15,3)
Vn8 = dado(18,3)

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
	
	fprintf(file, ".ic v(n6)=%f v(n8)=%fV\n", Vn6, Vn8);
	
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
	
	fprintf(file, ".ic v(n6)=%f v(n8)=%fV\n", Vn6, Vn8);
	
fclose(file);





