% 2. Circuito RC (Caixa Cinza)

% Parâmetros conhecidos/experimentais
R = 1000;  % resistência (ohm)
tau = 2;   % constante de tempo obtida experimentalmente (s)

% tau = R*C  =>  C = tau/R
C = tau / R;

% Mostra o valor encontrado para C
fprintf('Capacitância encontrada: C = %.6f F\n', C);

% Função de transferência do circuito RC (tensão no capacitor):
% Vc(s)/Vin(s) = 1 / (tau*s + 1)
num = 1;
den = [tau 1];

sys = tf(num, den);

disp('Função de transferência do circuito RC:');
sys

% Gráfico da resposta ao degrau durante 10 segundos
figure;
step(sys, 10);
xlabel('Tempo (s)');
ylabel('Tensão no capacitor (V)');
title('Resposta ao degrau - Circuito RC');
grid on;