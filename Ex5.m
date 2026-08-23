% 5. Gráficos 3D

% Valores de x entre 1 e 10, y entre 1 e 20
x = 1:0.5:10;
y = 1:0.5:20;

% Cria a malha (grade) de pontos
[X, Y] = meshgrid(x, y);

% Superfície z = sen(x) + cos(y)
Z = sin(X) + cos(Y);

% Representação tridimensional da superfície
figure;
surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('z');
title('Superfície z = sen(x) + cos(y)');
colormap(hot);   % tons quentes (pode trocar por 'summer' para tons esverdeados)
shading interp;  % deixa a transição entre cores suave
colorbar;

% Representação das curvas de nível da mesma superfície
figure;
contour(X, Y, Z, 20); % 20 = quantidade de níveis de contorno
xlabel('x');
ylabel('y');
title('Curvas de nível de z = sen(x) + cos(y)');
colormap(hot);
colorbar;
grid on;