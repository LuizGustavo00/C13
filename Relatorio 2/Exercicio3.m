%% Exercício 3 - Identificação e visualização de dados experimentais (Caixa Preta)
clear; clc; close all;

t = (0:25)';
u = [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
y = [0.008 0.012 0.006 0.010 0.020 0.382 0.671 0.903 1.082 1.226 1.335 1.425 ...
     1.492 1.547 1.587 1.618 1.642 1.660 1.674 1.684 1.692 1.698 1.702 1.706 ...
     1.709 1.711]';

% Figura 1 - entrada e saída
figure(1)
subplot(2,1,1)
plot(t,u,'b','LineWidth',1.5)
title('Sinal de entrada')
xlabel('Tempo (s)')
ylabel('Amplitude')
grid on

subplot(2,1,2)
plot(t,y,'r','LineWidth',1.5)
title('Sinal de saída')
xlabel('Tempo (s)')
ylabel('Amplitude')
grid on

% Figura 2 - plot3 (tempo, entrada, saída)
figure(2)
plot3(t,u,y,'LineWidth',1.5)
xlabel('Tempo (s)')
ylabel('Entrada')
zlabel('Saída')
grid on
title('Relação entre tempo, entrada e saída')

% Identificação do sistema
Ts = 1;
dados = iddata(y,u,Ts);
modelo = tfest(dados,1,0);   % 1 polo, 0 zeros

disp('Função de transferência estimada:')
modelo

% Comparação dados x modelo
figure(3)
compare(dados,modelo)
title('Comparação: dados experimentais x modelo identificado')
grid on

% Resposta ao degrau do modelo - 25 segundos
figure(4)
step(modelo,25)
title('Resposta ao degrau do modelo identificado')
xlabel('Tempo (s)')
ylabel('Amplitude')
grid on
