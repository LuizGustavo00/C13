% 1. Funções e gráficos 2D

% Vetor de tempo de 0 a 10 segundos, com passo de 0,1 segundo
t = 0:0.1:10;

% Parâmetros
A = 2;      % amplitude
w = 3;      % frequência angular (rad/s)

% Senoide e cossenoide
y_sen = A * sin(w * t);
y_cos = A * cos(w * t);

% Plotando as duas curvas na mesma figura
figure;
plot(t, y_sen, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, y_cos, 'r--', 'LineWidth', 1.5);
hold off;

% Identificação dos eixos, título, legenda e grade
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Senoide e Cossenoide (A = 2, \omega = 3 rad/s)');
legend('Senoide: 2sin(3t)', 'Cossenoide: 2cos(3t)');
grid on;

% Quantidade de elementos do vetor de tempo
n_elementos = length(t);
fprintf('Quantidade de elementos do vetor de tempo: %d\n', n_elementos);
