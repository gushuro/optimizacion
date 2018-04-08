function out = ej1(cantVertices)
%ej1 - Calcula el mayor área posible de un polígono de cantVertices lados
%
% Syntax: out = ej1(cantVertices)
%
% Dada una cantidad cantVertices de lados/vértices, el objetivo es encontrar el polígono que maximiza área.
% Al ser un problema difícil, utilizaremos  métodos de minimización con penalidad
    addpath('../tp2/')
    % CantVertices tendrá la cantidad de vértices no (0,0)
    cantVertices = cantVertices - 1;
    niter = 100000;
    
    funcObjetivo = @(x) -areaPoligono(x, cantVertices) + 10000*penalizacion(x, cantVertices);   %% hay que ir aumentando la penalización
    %r0 = ones(1,cantVertices);
    currentArgMax = [];
    currentMax = 0;
    for i=1:niter
        r0= rand(1,cantVertices);
        tita0 = sort(rand(1,cantVertices))*pi;
        %tita0 = linspace(0,pi,cantVertices+1);
        %tita0 = tita0(1:cantVertices);
        x0 = [r0, tita0];
        rmin = zeros(1,cantVertices);
        rmax = rmin +1;
        titamin= rmin;
        titamax = pi*rmax;
       % argmin = a3(funcObjetivo, [rmin, titamin], [rmax,titamax], 10000, 1, false);
        opcNumerico =  [1000, 0.0001, 0, 0.5, 0.5];
        argmin=a1(funcObjetivo, x0, 4, opcNumerico, funcObjetivo);
        % Ploteamos el resultado
%         rs = argmin(1:cantVertices)
%         titas = argmin(cantVertices+1:2*cantVertices)
%         x = [0, rs.*cos(titas),0];
%         y = [0, rs.*sin(titas),0];
%         plot(x,y)
        max = areaPoligono(argmin, cantVertices);
        if max > currentMax
            currentMax = max
            currentArgMax = argmin;
        end
    end
    % Ploteamos el resultado
        currentArgMax
        rs = currentArgMax(1:cantVertices)
        titas = currentArgMax(cantVertices+1:2*cantVertices)
        x = [0, rs.*cos(titas),0];
        y = [0, rs.*sin(titas),0];
        plot(x,y)
    % Área del polígono minimizador
    out = currentMax
end