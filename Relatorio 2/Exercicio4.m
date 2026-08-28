%% Exercício 4 - Análise de diferentes circuitos RC (Caixa Cinza)
clear; clc; close all;

R   = [1000 2000 3000 5000];
tau = [1.2 2.8 3.9 7.0];

C = tau./R;   % capacitância de cada experimento

disp('Capacitância de cada experimento (F):')
disp(C)

disp('Vetor R (Ohms):'); disp(R)
disp('Vetor tau (s):');  disp(tau)
disp('Vetor C (F):');    disp(C)

% Figura 1 - relação entre R, tau e C
figure(1)
plot3(R,tau,C,'o-','LineWidth',1.5,'MarkerFaceColor','b')
xlabel('Resistência (\Omega)')
ylabel('Constante de tempo (s)')
zlabel('Capacitância (F)')
grid on
title('Relação entre R, \tau e C nos experimentos')

% Experimento 3
R3   = R(3);
tau3 = tau(3);
sys3 = tf(1,[tau3 1]);

t = 0:0.01:20;
[y3,t3] = step(sys3,t);

figure(2)
plot(t3,y3,'b','LineWidth',1.5)
title('Resposta ao degrau - Experimento 3')
xlabel('Tempo (s)')
ylabel('Tensão (V)')
grid on

% Janela de ampliação - primeiros 5 segundos
axes('Position',[0.55 0.25 0.3 0.3])
box on
idx = t3 <= 5;
plot(t3(idx),y3(idx),'b','LineWidth',1.2)
title('Zoom: 0-5 s')
grid on
