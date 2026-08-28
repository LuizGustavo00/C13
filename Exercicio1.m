%% Exercício 1 - Sistema massa-atrito e comparação gráfica (Caixa Branca)
clear; clc; close all;

% Parâmetros dos sistemas
M1 = 2; B1 = 3;
M2 = 4; B2 = 6;

% Modelo: M*dv/dt + B*v = F(t)  ->  V(s)/F(s) = 1/(M*s + B)
sys1 = tf(1,[M1 B1]);
sys2 = tf(1,[M2 B2]);

disp('Função de transferência do Sistema 1:')
sys1
disp('Função de transferência do Sistema 2:')
sys2

% Resposta ao degrau - 20 segundos
t = 0:0.01:20;
[y1,t1] = step(sys1,t);
[y2,t2] = step(sys2,t);

% Figura 1 - respostas dos dois sistemas + força unitária
figure(1)
plot(t1,y1,'b','LineWidth',1.5); hold on
plot(t2,y2,'r','LineWidth',1.5)
plot(t,ones(size(t)),'k--','LineWidth',1)
title('Resposta ao degrau - Sistemas Massa-Atrito')
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
legend('Sistema 1 (M=2, B=3)','Sistema 2 (M=4, B=6)','Força unitária','Location','southeast')
grid on

% Janela de ampliação (inset) - primeiros 5 segundos
axes('Position',[0.5 0.5 0.3 0.3])
box on
idx = t <= 5;
plot(t1(idx),y1(idx),'b','LineWidth',1.2); hold on
plot(t2(idx),y2(idx),'r','LineWidth',1.2)
title('Zoom: 0-5 s')
grid on

% Figura 2 - respostas em subplots separados
figure(2)
subplot(2,1,1)
plot(t1,y1,'b','LineWidth',1.5)
title('Resposta ao degrau - Sistema 1')
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
grid on

subplot(2,1,2)
plot(t2,y2,'r','LineWidth',1.5)
title('Resposta ao degrau - Sistema 2')
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
grid on
