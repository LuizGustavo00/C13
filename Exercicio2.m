%% Exercício 2 - Circuito RC e comparação de escalas (Caixa Cinza)
clear; clc; close all;

R = 2000;      % Ohms
tau = 2.5;     % segundos (constante de tempo experimental)

C = tau/R;     % capacitância

disp('Valor da capacitância C (F):')
disp(C)

% Vc(s)/Vin(s) = 1/(R*C*s + 1)
sys = tf(1,[R*C 1]);
disp('Função de transferência do circuito RC:')
sys

% Resposta ao degrau - 15 segundos
figure(1)
step(sys,15)
title('Resposta ao degrau - Circuito RC')
xlabel('Tempo (s)')
ylabel('Tensão (V)')
grid on

% Vetor de resistências, mantendo o capacitor calculado
Rteste = 100:100:10000;
tauTeste = Rteste*C;   % tau = R*C

figure(2)
subplot(2,2,1)
plot(Rteste,tauTeste,'b','LineWidth',1.2)
title('Escala linear')
xlabel('Resistência (\Omega)')
ylabel('Constante de tempo (s)')
grid on

subplot(2,2,2)
semilogy(Rteste,tauTeste,'r','LineWidth',1.2)
title('Escala log no eixo Y')
xlabel('Resistência (\Omega)')
ylabel('Constante de tempo (s)')
grid on

subplot(2,2,3)
semilogx(Rteste,tauTeste,'g','LineWidth',1.2)
title('Escala log no eixo X')
xlabel('Resistência (\Omega)')
ylabel('Constante de tempo (s)')
grid on

subplot(2,2,4)
loglog(Rteste,tauTeste,'m','LineWidth',1.2)
title('Escala log-log')
xlabel('Resistência (\Omega)')
ylabel('Constante de tempo (s)')
grid on
