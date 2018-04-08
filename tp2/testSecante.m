%% test A3

%% Funciones de ejemplo


f = @(x)(x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);
gf = @(x)[4*(x(1)-x(2)).^3+4*x(1)-1,(-4)*(x(1)-x(2)).^3+2*x(2)+2];

%Opciones para probar. Usa gradiente analítico/numérico
% opciones=[MaxNumIter, tolGrad, gradHess, alpha, theta]
opcAnalitico = [100, 0.001, 1, 0.5, 0.5];
opcNumerico =  [100, 0.001, 0, 0.5, 0.5];

times = zeros(5,2)

for i = 1:4
    tic;
    for j = 1:200
        a1(f, [1,1], i, opcAnalitico, gf); 
    end
    times(i,1) = toc;
end

for i = 1:4
    tic;
    for j = 1:200
        a1(f, [1,1], i, opcNumerico, gf);
    end
    times(i,2) = toc;
end

opcAnalitico = [100, 0.001, 0.001, 1];
opcNumerico =  [100, 0.001, 0.001, 0];

tic
for j = 1:200
    a3(f, [1,1], opcNumerico, gf);
end
times(5,1) = toc;

tic
for j = 1:200
    a3(f, [1,1], opcAnalitico, gf);
end
times(5,2) = toc;

times

%% Plotear
busqueda = {'fminsearch', 'fminbnd', 'triseccion', 'armijo', 'secante'};
bar1 = bar(times)
set(gca, 'XTickLabel',busqueda, 'XTick',1:numel(busqueda));
set(bar1(1),'DisplayName','Analitico');
set(bar1(2),'DisplayName','Numerico');

