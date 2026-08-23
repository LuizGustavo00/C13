% 1. Sistema massa-mola-amortecedor (Caixa Branca)

% Parâmetros do sistema
M = 2;  % massa (kg)
B = 3;  % coeficiente de amortecimento
K = 8;  % constante elástica

% Modelo: M*x'' + B*x' + K*x = F(t)
% Função de transferência: X(s)/F(s) = 1 / (M*s^2 + B*s + K)
num = 1;
den = [M B K];

sys = tf(num, den);

% Mostra a função de transferência no Command Window
disp('Função de transferência do sistema massa-mola-amortecedor:');
sys

% Gráfico da resposta ao degrau durante 15 segundos
figure;
step(sys, 15);
xlabel('Tempo (s)');
ylabel('Deslocamento x(t)');
title('Resposta ao degrau - Sistema massa-mola-amortecedor');
grid on;