

close all
clear all


%pkg load symbolic


R1 = 1.00359089673 *1000;
R2 = 2.04298963569 *1000;
R3 = 3.02503141993 *1000;
R4 = 4.05647775356 *1000;
R5 = 3.07781188185 *1000;
R6 = 2.01277040929 *1000;
R7 = 1.01993304256 *1000;
Vs= 5.11402517827;
C = 1.03896393154 *0.000001;
Kb = 7.23768458527 *0.001;
Kd = 8.33526265782 *1000;



G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;


%{
A = [1 0 0 -1 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 0 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 0 -1 0;...
    G1 -G1 0 (G6+G4) -G4 0 -G6 0 0 0 0;...
    0 G3 0 G4 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 G6 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1;...
    0 0 0 -G6*Kd 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 0 -Kb 0 0 0 0 -1 0];
    
B = [Vs;0;0;0;0;0;0;0;0;0;0];

%}
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

V1 = res(1)
V2 = res(2)
V3 = res(3)
V4 = 0
V5 = res(4)
V6 = res(5)
V7 = res(6)
V8 = res(7)


Iv = res(8)
Ib = res(9)
Ic = res(10)





    
%%PARTE 2

Vx = V6 - V8
%{
A = [1 0 0 -1 0 0 0 0 0 0 0;...
    G1 -(G1+G2+G3) G2 0 G3 0 0 0 0 0 0;...
    0 -G2 G2 0 0 0 0 0 0 -1 0;...
    G1 -G1 0 (G6+G4) -G4 0 -G6 0 0 0 0;...
    0 G3 0 G4 -(G3+G5+G4) G5 0 0 1 0 0;...
    0 0 0 0 -G5 G5 0 0 0 1 1;...
    0 0 0 0 0 0 G7 -G7 -1 0 1;...
    0 0 0 G6 0 0 -(G6+G7) G7 0 0 0;
    0 0 0 0 0 1 0 -1 0 0 0;...
    0 0 0 -G6*Kd 1 0 G6*Kd -1 0 0 0;...
    0 Kb 0 0 -Kb 0 0 0 0 -1 0];
    
B = [0;0;0;0;0;0;0;0;Vx;0;0];
%}    
    
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

Ic = res(10)
V6_i = res(5)

Req = abs(Vx/Ic)
t_c = Req*C


%% PARTE 3
t = [0:1e-6:20e-3];
V6_t_natural = V6_i * exp(-t/t_c);

hf=figure();
plot(t*1000, V6_t_natural, "g");

xlabel("t(ms)");
ylabel("V");



%% PARTE 4
f=1e3;   %HZ
w=f*2*pi;
Z_c = -j/(w*C);


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


%%  PARTE 5
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
    
    
%% PARTE 6
l = 50;
f = logspace(-1, 6, l);
v6 = ones(l,1);
v6_ph = ones(l,1);


v6_8 = ones(l, 1);
v6_8_ph = ones(l,1);

p = 1;
for t = f

w=t*2*pi;
Z_c = -j/(w*C);


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


    
    
    
  
