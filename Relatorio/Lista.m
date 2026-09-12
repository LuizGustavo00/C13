%% Relatorio 3 - Sistemas de Primeira e Segunda Ordem

clear; clc; close all;

%% 1. Identificacao de um sistema de primeira ordem a partir de um ensaio

K1   = 1.8;
tau1 = 1.2;

G1 = tf(K1, [tau1 1]);

polo1  = pole(G1);
tr1    = 2.2*tau1;          % tempo de subida (10%-90%), criterio 1a ordem
ts1    = 4*tau1;            % tempo de acomodacao (2%)
ganho1 = dcgain(G1);        % ganho em regime permanente

fprintf('===== Exercicio 1 =====\n');
fprintf('Funcao de transferencia: G(s) = %.2f / (%.2fs + 1)\n', K1, tau1);
fprintf('Ganho K = %.4f\n', K1);
fprintf('Constante de tempo tau = %.4f s\n', tau1);
fprintf('Polo do sistema: s = %.4f\n', polo1);
fprintf('Tempo de subida (10-90%%): tr = %.4f s\n', tr1);
fprintf('Tempo de acomodacao (2%%): ts = %.4f s\n', ts1);
fprintf('Ganho em regime permanente: %.4f\n', ganho1);

t = 0:0.01:8;

figure;
step(G1, t);
title('Resposta ao degrau unitario - Sistema de 1a ordem');
xlabel('Tempo (s)');
ylabel('Saida');
grid on;

% Entrada em degrau de amplitude 2.5
amp2 = 2.5;
[y2, t2] = step(G1, t);
y2 = amp2*y2;
valorFinal2 = ganho1*amp2;

fprintf('Novo valor final (degrau de amplitude %.1f): %.4f\n\n', amp2, valorFinal2);

figure;
plot(t2, y2, 'LineWidth', 1.5);
title(sprintf('Resposta a um degrau de amplitude %.1f - Sistema de 1a ordem', amp2));
xlabel('Tempo (s)');
ylabel('Saida');
grid on;


%% 2. Escolha entre tres sistemas de segunda ordem
num2 = 25;
denA = [1 3  25];
denB = [1 10 25];
denC = [1 16 25];

GA = tf(num2, denA);
GB = tf(num2, denB);
GC = tf(num2, denC);

sistemas2 = {GA, GB, GC};
nomes2    = {'A', 'B', 'C'};

fprintf('===== Exercicio 2 =====\n');
for k = 1:3
    sys = sistemas2{k};
    [wn, zeta, p] = damp(sys);
    ganho = dcgain(sys);
    if zeta(1) < 1
        tipo = 'subamortecido';
    elseif abs(zeta(1) - 1) < 1e-6
        tipo = 'criticamente amortecido';
    else
        tipo = 'superamortecido';
    end
    fprintf('Sistema %s:\n', nomes2{k});
    fprintf('  Polos: %s\n', mat2str(p, 4));
    fprintf('  Frequencia natural wn = %.4f rad/s\n', wn(1));
    fprintf('  Coeficiente de amortecimento zeta = %.4f\n', zeta(1));
    fprintf('  Tipo de resposta: %s\n', tipo);
    fprintf('  Ganho em regime permanente = %.4f\n', ganho);
end
fprintf('\n');

figure;
step(GA, GB, GC, t);
legend('Sistema A', 'Sistema B', 'Sistema C');
title('Resposta ao degrau unitario - Sistemas A, B e C');
xlabel('Tempo (s)');
ylabel('Saida');
grid on;

figure;
hold on;
pA = pole(GA); pB = pole(GB); pC = pole(GC);
plot(real(pA), imag(pA), 'x', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(pB), imag(pB), 'o', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(pC), imag(pC), 's', 'MarkerSize', 10, 'LineWidth', 2);
legend('Polos A', 'Polos B', 'Polos C');
title('Posicao dos polos - Sistemas A, B e C');
xlabel('Eixo Real');
ylabel('Eixo Imaginario');
grid on;
hold off;

infoB = stepinfo(GB);
infoC = stepinfo(GC);
if infoB.SettlingTime < infoC.SettlingTime
    maisRapido = 'B';
else
    maisRapido = 'C';
end
fprintf('Tempo de acomodacao B = %.4f s | Tempo de acomodacao C = %.4f s\n', ...
    infoB.SettlingTime, infoC.SettlingTime);
fprintf('Sistema mais adequado (sem sobressinal e mais rapido): Sistema %s\n\n', maisRapido);

%% 3. Avaliacao de desempenho de dois sistemas de segunda ordem
G3_1 = tf(16, [1 2.8 16]);
G3_2 = tf(25, [1 6.5 25]);

sistemas3 = {G3_1, G3_2};
nomes3    = {'Sistema 1', 'Sistema 2'};

fprintf('===== Exercicio 3 =====\n');
resultados3 = struct();
for k = 1:2
    sys = sistemas3{k};
    [wn, zeta, p] = damp(sys);
    wn = wn(1); zeta = zeta(1);
    wd = wn*sqrt(1-zeta^2);
    theta = acos(zeta);

    valorFinal = dcgain(sys);
    td = (1 + 0.7*zeta)/wn;              % tempo de atraso (50%)
    trSub = (pi - theta)/wd;             
    tp = pi/wd;                          
    Mp = exp(-zeta*pi/sqrt(1-zeta^2));   
    primeiroPico = valorFinal*(1+Mp);
    ts2 = 4/(zeta*wn);                   % tempo de acomodacao (2%)

    fprintf('%s:\n', nomes3{k});
    fprintf('  Valor final = %.4f\n', valorFinal);
    fprintf('  Tempo de atraso (50%%) td = %.4f s\n', td);
    fprintf('  Tempo de subida tr = %.4f s\n', trSub);
    fprintf('  Tempo de pico tp = %.4f s\n', tp);
    fprintf('  Valor do primeiro pico = %.4f\n', primeiroPico);
    fprintf('  Sobressinal maximo Mp = %.2f%%\n', Mp*100);
    fprintf('  Tempo de acomodacao (2%%) ts = %.4f s\n', ts2);
    fprintf('  Frequencia natural wn = %.4f rad/s\n', wn);
    fprintf('  Coeficiente de amortecimento zeta = %.4f\n', zeta);
    fprintf('  Polos: %s\n', mat2str(p, 4));

    resultados3(k).Mp = Mp*100;
    resultados3(k).ts = ts2;
end
fprintf('\n');

figure;
step(G3_1, G3_2, t);
legend('Sistema 1', 'Sistema 2');
title('Resposta ao degrau unitario - Sistemas 1 e 2');
xlabel('Tempo (s)');
ylabel('Saida');
grid on;

% Verificacao dos requisitos: Mp < 10% e ts < 1.5 s
for k = 1:2
    atendeMp = resultados3(k).Mp < 10;
    atendeTs = resultados3(k).ts < 1.5;
    if atendeMp && atendeTs
        fprintf('%s ATENDE aos requisitos (Mp < 10%% e ts < 1.5 s)\n', nomes3{k});
    else
        fprintf('%s NAO atende aos requisitos (Mp < 10%% e ts < 1.5 s)\n', nomes3{k});
    end
end
fprintf('\n');


%% 4. Selecao de parametros para um sistema de segunda ordem
zetas = [0.35 0.55 0.70 0.80];
wns   = [6    5    4    3.2];
nomes4 = {'A','B','C','D'};

fprintf('===== Exercicio 4 =====\n');
Mp4 = zeros(1,4);
ts4 = zeros(1,4);
tr4 = zeros(1,4);
sistemas4 = cell(1,4);

figure; hold on;
for k = 1:4
    zeta = zetas(k);
    wn   = wns(k);
    sys  = tf(wn^2, [1 2*zeta*wn wn^2]);
    sistemas4{k} = sys;

    wd = wn*sqrt(1-zeta^2);
    theta = acos(zeta);

    p = pole(sys);
    Mp = exp(-zeta*pi/sqrt(1-zeta^2));
    trSub = (pi - theta)/wd;
    tp = pi/wd;
    ts2 = 4/(zeta*wn);
    valorFinal = dcgain(sys);

    Mp4(k) = Mp*100;
    ts4(k) = ts2;
    tr4(k) = trSub;

    fprintf('Configuracao %s (zeta = %.2f, wn = %.1f rad/s):\n', nomes4{k}, zeta, wn);
    fprintf('  Polos: %s\n', mat2str(p, 4));
    fprintf('  Sobressinal maximo Mp = %.2f%%\n', Mp*100);
    fprintf('  Tempo de subida tr = %.4f s\n', trSub);
    fprintf('  Tempo de pico tp = %.4f s\n', tp);
    fprintf('  Tempo de acomodacao (2%%) ts = %.4f s\n', ts2);
    fprintf('  Valor final da resposta ao degrau unitario = %.4f\n', valorFinal);

    step(sys, t);
end
legend('Configuracao A', 'Configuracao B', 'Configuracao C', 'Configuracao D');
title('Resposta ao degrau unitario - Configuracoes A, B, C e D');
xlabel('Tempo (s)');
ylabel('Saida');
grid on;
hold off;
fprintf('\n');

% Verificacao dos requisitos: Mp < 10% e ts < 1.5 s
validas = false(1,4);
for k = 1:4
    validas(k) = (Mp4(k) < 10) && (ts4(k) < 1.5);
    if validas(k)
        fprintf('Configuracao %s ATENDE aos requisitos\n', nomes4{k});
    else
        fprintf('Configuracao %s NAO atende aos requisitos\n', nomes4{k});
    end
end

idxValidas = find(validas);
[~, idxMin] = min(tr4(idxValidas));
escolhida = nomes4{idxValidas(idxMin)};
fprintf('Configuracao selecionada (menor tempo de subida entre as validas): %s\n\n', escolhida);


%% 5. Comparacao entre sistemas de primeira e segunda ordem
GA5 = tf(2, [1.2 1]);          % Equipamento A - 1a ordem
GB5 = tf(32, [1 5.6 16]);      % Equipamento B - 2a ordem

fprintf('===== Exercicio 5 =====\n');

% Equipamento A (1a ordem)
poloA5 = pole(GA5);
KA5 = dcgain(GA5);
tauA5 = 1.2;
trA5 = 2.2*tauA5;
tsA5 = 4*tauA5;

fprintf('Equipamento A (1a ordem):\n');
fprintf('  Polo: s = %.4f\n', poloA5);
fprintf('  Ganho em regime permanente = %.4f\n', KA5);
fprintf('  Valor final da resposta (degrau unitario) = %.4f\n', KA5*1);
fprintf('  Tempo de subida (10-90%%) tr = %.4f s\n', trA5);
fprintf('  Tempo de acomodacao (2%%) ts = %.4f s\n', tsA5);

% Equipamento B (2a ordem)
[wnB5, zetaB5, poloB5] = damp(GB5);
wnB5 = wnB5(1); zetaB5 = zetaB5(1);
wdB5 = wnB5*sqrt(1-zetaB5^2);
thetaB5 = acos(zetaB5);

KB5 = dcgain(GB5);
trB5 = (pi - thetaB5)/wdB5;
tsB5 = 4/(zetaB5*wnB5);
tpB5 = pi/wdB5;
MpB5 = exp(-zetaB5*pi/sqrt(1-zetaB5^2));
picoB5 = KB5*(1+MpB5);

fprintf('Equipamento B (2a ordem):\n');
fprintf('  Polos: %s\n', mat2str(poloB5, 4));
fprintf('  Ganho em regime permanente = %.4f\n', KB5);
fprintf('  Valor final da resposta (degrau unitario) = %.4f\n', KB5*1);
fprintf('  Tempo de subida tr = %.4f s\n', trB5);
fprintf('  Tempo de acomodacao (2%%) ts = %.4f s\n', tsB5);
fprintf('  Frequencia natural wn = %.4f rad/s\n', wnB5);
fprintf('  Coeficiente de amortecimento zeta = %.4f\n', zetaB5);
fprintf('  Tempo de pico tp = %.4f s\n', tpB5);
fprintf('  Valor do primeiro pico = %.4f\n', picoB5);
fprintf('  Sobressinal maximo Mp = %.2f%%\n\n', MpB5*100);

figure;
step(GA5, GB5, t);
legend('Equipamento A (1a ordem)', 'Equipamento B (2a ordem)');
title('Resposta ao degrau unitario - Equipamentos A e B');
xlabel('Tempo (s)');
ylabel('Saida');
grid on;

% Entrada em degrau de amplitude 1.5
amp5 = 1.5;
valorFinalA5_amp = KA5*amp5;
valorFinalB5_amp = KB5*amp5;

fprintf('Com degrau de amplitude %.1f:\n', amp5);
fprintf('  Valor final Equipamento A = %.4f\n', valorFinalA5_amp);
fprintf('  Valor final Equipamento B = %.4f\n\n', valorFinalB5_amp);

[yA5, tA5] = step(GA5, t);
[yB5, tB5] = step(GB5, t);
yA5 = amp5*yA5;
yB5 = amp5*yB5;

figure;
plot(tA5, yA5, 'LineWidth', 1.5); hold on;
plot(tB5, yB5, 'LineWidth', 1.5);
legend('Equipamento A (1a ordem)', 'Equipamento B (2a ordem)');
title(sprintf('Resposta a um degrau de amplitude %.1f - Equipamentos A e B', amp5));
xlabel('Tempo (s)');
ylabel('Saida');
grid on;
hold off;

