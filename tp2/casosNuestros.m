%% Funciones de ejemplo


f = @(x)(x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);
gf = @(x)[4*(x(1)-x(2)).^3+4*x(1)-1,(-4)*(x(1)-x(2)).^3+2*x(2)+2];

%Opciones para probar. Usa gradiente analítico/numérico
% opciones=[MaxNumIter, tolGrad, gradHess, alpha, theta]
opcAnalitico = [100, 0.001, 1, 0.5, 0.5];
opcNumerico =  [100, 0.001, 0, 0.5, 0.5];

posta = fminsearch(f, [1,1]);

resultadosAn = zeros(4,1);
resultadosNum = zeros(4,1);
times = zeros(4,2)
tic
for i = 1:4
    tic;
    for j = 1:200
        resultadosAn(i) = norm(a1(f, [1,1], i, opcAnalitico, gf) - posta); 
    end
    times(i,1) = toc;
end

for i = 1:4
    tic;
    for j = 1:200
        resultadosNum(i) =norm( a1(f, [1,1], i, opcNumerico, gf) - posta);
    end
    times(i,2) = toc;
end

resultadosAn
resultadosNum

times

%% Plotear
busqueda = {'fminsearch', 'fminbnd', 'triseccion', 'armijo'};
bar1 = bar(times)
set(gca, 'XTickLabel',busqueda, 'XTick',1:numel(busqueda));
set(bar1(1),'DisplayName','Analitico');
set(bar1(2),'DisplayName','Numerico');


%% Funciones de prueba

addpath('testFunctions/single-objective/')
times = zeros(4,3)
posta = fminsearch(@ackley, [1,1]);

tic
for i = 1:4
    tic;
    for j = 1:100
        a1(@ackley, [1,1], i, opcNumerico, @ackley); 
    end
    times(i,1) = toc;
end

posta = fminsearch(@ackley, [1,1]);

tic
for i = 1:4
    tic;
    for j = 1:100
        a1(@eggholder, [1,1], i, opcNumerico, @eggholder); 
    end
    times(i,2) = toc;
end

posta = fminsearch(@ackley, [1,1]);

tic
for i = 1:4
    tic;
    for j = 1:1000
        a1(@leon, [1,1], i, opcNumerico, @leon); 
    end
    times(i,3) = toc;
end

%% Ploteamos

funcion = {'Ackley', 'Eggholder', 'Leon'};
bar1 = bar(times')
set(gca, 'XTickLabel',funcion, 'XTick',1:numel(funcion));
set(bar1(1),'DisplayName','fminsearch');
set(bar1(2),'DisplayName','fminbnd');
set(bar1(3),'DisplayName','Triseccion');
set(bar1(4),'DisplayName','Armijo');


%% Testeamos Gradiente Conjugado

f = @(x)3*x(2)^2+x(1)^2+2*x(1)*x(2)+x(1)+3*x(2)
gf = @(x)[2*x(1)+2*x(2)+1,6*x(2)+2*x(1)+3]
hf = @(x)[2,2;2,6]
opcAnalitico = [100, 0.001, 1, 0.5, 0.5];
opcNumerico =  [100, 0.001, 0, 0.5, 0.5];

% Con las derivadas calculadas de manera analítica:
res1 = a2(f, [1,1], opcAnalitico, gf, hf);
res2 = a2(f, [1,1], opcNumerico, f, f);



