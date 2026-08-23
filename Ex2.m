% 2. Entrada de dados, condição e gráfico

% Pede ao usuário o coeficiente 'a'
a = input('Digite o valor do coeficiente a: ');

% Vetor de x entre -10 e 10
x = -10:0.1:10;

% Função y = a*x + 2
y = a * x + 2;

% Informa se o coeficiente é positivo, negativo ou zero
if a > 0
    disp('O coeficiente a é positivo.');
elseif a < 0
    disp('O coeficiente a é negativo.');
else
    disp('O coeficiente a é igual a zero.');
end

% Gráfico principal da função
figure;
plot(x, y, 'b-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Gráfico da função y = a\cdotx + 2');
grid on;

% Janela pequena dentro da figura, destacando a região -2 <= x <= 2
axes('Position', [0.6 0.2 0.25 0.25]); % [esquerda base largura altura] (proporção da figura)
box on;

% Filtra apenas os pontos dentro da faixa desejada
idx = (x >= -2) & (x <= 2);
plot(x(idx), y(idx), 'r-', 'LineWidth', 1.5);
title('Zoom: -2 \leq x \leq 2');
xlim([-2 2]);
grid on;