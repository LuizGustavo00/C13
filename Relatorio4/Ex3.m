% 3. Sistema massa-atrito (Caixa Cinza)

% Parâmetros conhecidos
M = 4;   % massa (kg)
F = 1;   % força aplicada (N)

% Dado experimental: velocidade estabilizou em 0,5 m/s
v_ss = 0.5;

% Modelo: M*v' + b*v = F
% Em regime permanente (v' = 0): b*v_ss = F  =>  b = F/v_ss
b = F / v_ss;

% Mostra o valor encontrado para b
fprintf('Coeficiente de atrito encontrado: b = %.4f N.s/m\n', b);

% Função de transferência: V(s)/F(s) = 1 / (M*s + b)
num = 1;
den = [M b];

sys = tf(num, den);

disp('Função de transferência do sistema massa-atrito:');
sys

% Gráfico da resposta à mesma força aplicada no experimento
figure;
step(F * sys); % multiplicamos por F para simular a força aplicada de 1 N
xlabel('Tempo (s)');
ylabel('Velocidade v(t) (m/s)');
title('Resposta do sistema massa-atrito à força aplicada');
grid on;