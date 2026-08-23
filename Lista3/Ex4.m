% 4. Comparação de escalas

% Vetor de t com valores positivos até 1000
t = 1:1000;

% Função y = 50000 * e^(-0.05*t)
y = 50000 * exp(-0.05 * t);

% Dois gráficos na mesma janela
figure;

subplot(2,1,1); % escala comum nos dois eixos
plot(t, y, 'b-', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Escala comum (linear)');
grid on;

subplot(2,1,2); % escala logarítmica apenas no eixo vertical
semilogy(t, y, 'r-', 'LineWidth', 1.5);
xlabel('t');
ylabel('y (escala log)');
title('Escala logarítmica no eixo y');
grid on;
