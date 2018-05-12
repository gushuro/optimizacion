function out = ej1Recocido(cantVertices)
global x y
%ej1 - Calcula el mayor área posible de un polígono de cantVertices lados
%
% Syntax: out = ej1Recocido(cantVertices)
%
% Dada una cantidad cantVertices de lados/vértices, el objetivo es
% encontrar el mayor área alcanzable por un polígono de dicha cantidad de
% lados, y diámetro 1.
% Al ser un problema difícil, utilizaremos métodos de minimización con penalidad
    close all;
    %addpath('../../tp3/')
    [rCero, titaCero] = generarRegular(cantVertices);
    xCero = [rCero, titaCero];
    % CantVertices tendrá la cantidad de vértices no (0,0)
    cantVertices = cantVertices - 1;
    niter = 30;
    
    currentArgMax = [];
    currentMax = 0;
    
    areaRegular = areaPoligono([rCero, titaCero], cantVertices);
    print = ['El area del regular es: ', num2str(areaRegular)];    
    disp(print);
    
    for i=1:niter
        iteracionesRestantes = niter-i
        funcObjetivo = @(x) -areaPoligono(x, cantVertices) + 2^i*0.1*penalizacion(x, cantVertices);   %% hay que ir aumentando la penalización
        rmin = zeros(1,cantVertices);
        rmax = rmin + 1;
        titamin= rmin;
        titamax = pi*rmax;
        [argmin, MIN] = recocidoSimulado(funcObjetivo, [rmin, titamin]-0.5, [rmax, titamax]+0.5, 1ej00000, 100, xCero);

        currentMax = areaPoligono(argmin, cantVertices)
        xCero = argmin;
        currentArgMax = argmin;
        
    end
    % Ploteamos el resultado
    rs = currentArgMax(1:cantVertices);
    titas = currentArgMax(cantVertices+1:2*cantVertices);
    x = [0, rs.*cos(titas),0];
    y = [0, rs.*sin(titas),0];
    
    plot(x,y)
    title(['N=', num2str(cantVertices+1), ' ', '- Recocido'])
    legend(strcat('Regular: ', num2str(areaRegular)), strcat('Obtenido: ', num2str(currentMax)))
    % Área del polígono minimizador
    PenalizacionFinal = penalizacion(currentArgMax, cantVertices)
    res = currentArgMax
    out = currentMax;
end