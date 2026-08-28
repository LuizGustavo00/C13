%% Exercício 5 - Análise completa de três tipos de modelagem
clear; clc; close all;

%% Sistema A - Caixa Branca (massa-atrito)
M = 3; B = 5;
sysA = tf(1,[M B]);

%% Sistema B - Caixa Cinza (circuito RC)
R = 1500; tau = 3;
C = tau/R;
sysB = tf(1,[R*C 1]);

%% Sistema C - Caixa Preta (identificação)
t = (0:20)';
u = [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
y = [0.010 0.006 0.012 0.018 0.408 0.706 0.934 1.103 1.229 1.322 1.391 1.441 ...
     1.479 1.505 1.526 1.540 1.551 1.558 1.564 1.568 1.571]';
Ts = 1;
dados = iddata(y,u,Ts);
sysC = tfest(dados,1,0);   % 1 polo, 0 zeros

% Mostrar tudo no Command Window
disp('Função de transferência do Sistema A (Caixa Branca):')
sysA
disp('Capacitância calculada do Sistema B (F):')
disp(C)
disp('Função de transferência do Sistema B (Caixa Cinza):')
sysB
disp('Função de transferência estimada do Sistema C (Caixa Preta):')
sysC

% Figura 1 - respostas ao degrau (20 s) empilhadas
tsim = 0:0.01:20;
figure(1)
subplot(3,1,1)
step(sysA,tsim)
title('Resposta ao degrau - Sistema A (Caixa Branca)')
grid on

subplot(3,1,2)
step(sysB,tsim)
title('Resposta ao degrau - Sistema B (Caixa Cinza)')
grid on

subplot(3,1,3)
step(sysC,tsim)
title('Resposta ao degrau - Sistema C (Caixa Preta)')
grid on

% Figura 2 - entrada e saída do Sistema C
figure(2)
subplot(2,1,1)
plot(t,u,'b','LineWidth',1.5)
title('Sistema C - Entrada')
xlabel('Tempo (s)')
ylabel('Amplitude')
grid on

subplot(2,1,2)
plot(t,y,'r','LineWidth',1.5)
title('Sistema C - Saída')
xlabel('Tempo (s)')
ylabel('Amplitude')
grid on

% Comparação dados experimentais x modelo (Sistema C)
figure(3)
compare(dados,sysC)
title('Comparação: dados experimentais x modelo (Sistema C)')
grid on

%% Comentários finais
% Sistema A é caixa branca: o modelo foi obtido diretamente das leis
% físicas conhecidas do sistema (2ª lei de Newton), sem uso de dados
% experimentais.
%
% Sistema B é caixa cinza: a estrutura do modelo (RC de 1ª ordem) já era
% conhecida, mas um dos parâmetros (capacitância) precisou ser calculado
% a partir de uma medição experimental (constante de tempo).
%
% Sistema C é caixa preta: nenhuma informação prévia sobre a estrutura
% física foi usada; o modelo foi obtido inteiramente a partir de dados
% de entrada e saída, via identificação de sistemas (tfest).
