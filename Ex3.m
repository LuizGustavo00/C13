% 3. Repetição e organização de gráficos

% Cria os cinco primeiros múltiplos de 3 usando um laço de repetição
multiplos = zeros(1,5);
for i = 1:5
    multiplos(i) = 3 * i;
end

% Vetor com o dobro dos valores obtidos
dobro = 2 * multiplos;

% Dois gráficos separados, um acima do outro, na mesma janela
figure;

subplot(2,1,1); % 2 linhas, 1 coluna, gráfico 1 (de cima)
plot(1:5, multiplos, 'bo-', 'LineWidth', 1.5);
xlabel('Índice');
ylabel('Valor');
title('Cinco primeiros múltiplos de 3');
grid on;

subplot(2,1,2); % 2 linhas, 1 coluna, gráfico 2 (de baixo)
plot(1:5, dobro, 'rs-', 'LineWidth', 1.5);
xlabel('Índice');
ylabel('Valor');
title('Dobro dos múltiplos de 3');
grid on;