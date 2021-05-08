clear all
close all
clc

format long

function v_out = v_source(f, A, t)
  v_out = A*sin(2*pi*f*t);
endfunction


function v_out = transformer(v, n)
  v_out = v / n;
endfunction

function v_out = Full_Bridge_Rectifier(v, V_in)
  v_out = abs(v);
  v_out(v_out<(2*V_in)) = V_in*2;
  v_out = v_out - V_in*2;
endfunction

function v_out = Capacitor(v, C, R, dt)
  s = size(v,2);
  tau = (R*C);
  v_out = zeros(1,s);
  v_out(1) = v(1);
  for i = 1:s-1;
    n_v = v_out(i)*exp(-dt/tau);
    if n_v > v(i+1);
      v_out(i+1) = n_v;
    else
      v_out(i+1) = v(i+1);
    endif
  endfor
endfunction

function v_out = v_regulator(v, R, Is, VT, n)
  v_avg = mean(v);
  v_diodo = new_raph(0.7, v_avg, R, n, Is, VT);
  r_diodo = VT*n/( Is*(exp(v_diodo/(VT*n))));
  
  i = (v - v_avg)/(R + r_diodo);
  
  v_out = i*r_diodo + v_diodo;
  
  
endfunction

function res = new_raph(x_1, v_avg, R, n, Is, VT)
  error = 1e-9;
  i = 1;
  do
    x_0 = x_1;
    x_1 = x_0 - f(x_1, v_avg, R, n, Is, VT)/df(x_1, R, n, Is, VT);
    i = i + 1;
  until (abs(x_1-x_0) < error) || (i > 100)
  res = x_1;
endfunction

function res = f(v_diodo,vS,R,n, Is, VT)
  
  res  = v_diodo + R*Is*(exp(v_diodo/(VT*n))-1) - vS;
  
endfunction

function df = df(v_diodo,R,n, Is, VT)
  
  df  = 1 + R*Is/(VT*n)*(exp(v_diodo/(VT*n)));
  
endfunction


%% Definições de simulação
t_i = 0
t_f = 0.2
step = 1000

%% Parâmetros da fonte de tensão
f = 50
A = 230

%% Parâmetros do Diodo
v_in = 0.7;
n = 17;
Is  = 1e-14;
VT  = 26e-3;

%% Parâmetros do filtro
C = 1e-5
R1 = 1e3
R2 = 6884.5



t = linspace(t_i,t_f, step);
dt = (t_f-t_i)/step;

v = v_source(f, A, t);

v = transformer(v, 3.241334);

v = Full_Bridge_Rectifier(v, v_in);

v = Capacitor(v, C, R1, dt);

hf=figure();
plot(t,v);
hold on
plot(t, 12*ones(1,size(t,2)));

legend( 'Envelope Detector Output', '12V');

ylim([0 15])
xlabel("t(ms)");
ylabel("Potencial (V)");

print(hf, "envelope_detector.eps", "-depsc");

v = v_regulator(v, R2, Is, VT, n);

hf=figure();
plot(t,v);
hold on
plot(t, 12*ones(1,size(t,2)));

legend( 'Voltage Regulator Output', '12V');

ylim([0 15])
xlabel("t(ms)");
ylabel("Potencial (V)");

print(hf, "voltage_regulator.eps", "-depsc");

cost = (R1+R2)/1000 + C*(10**6) + (4+n)*0.1
s = step/2
average = mean(v(s:end))
ripple = max(v(s:end))-min(v(s:end))
merit = 1/(cost*((average-12) + ripple + 1e-6))

