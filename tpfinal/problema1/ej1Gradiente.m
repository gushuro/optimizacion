function out = ej1Gradiente(cantVertices)
global x y
%ej1 - Calcula el mayor área posible de un polígono de cantVertices lados
%
% Syntax: out = ej1Gradiente(cantVertices)
%
% Dada una cantidad cantVertices de lados/vértices, el objetivo es
% encontrar el mayor área alcanzable por un polígono de dicha cantidad de
% lados, y diámetro 1.
% Al ser un problema difícil, utilizaremos métodos de minimización con penalidad
    close all;
    %addpath('../../tp3/')
    [rCero, titaCero] = generarRegular(cantVertices);
%     areaRegular = areaPoligono([rCero, titaCero], cantVertices-1);
%     rCero = ones(size(rCero))
%     titaCero = sort(rand(size(rCero))*pi)
    xCero = [rCero, titaCero];
    % CantVertices tendrá la cantidad de vértices no (0,0)
    cantVertices = cantVertices - 1;
    niter = 50;
    
    currentArgMax = [];
    currentMax = 0;
    
    areaRegular = areaPoligono([rCero, titaCero], cantVertices);
    print = ['El area del regular es: ', num2str(areaRegular)];
    disp(print);
    
    for i=1:niter
        iteracionesRestantes = niter-i
        funcObjetivo = @(x) -areaPoligono(x, cantVertices) + 1.5^i*penalizacion(x, cantVertices);   %% hay que ir aumentando la penalización
        rmin = zeros(1,cantVertices);
        rmax = rmin +1;
%         titamin= rmin;
%         titamax = pi*rmax;
%         argmin = a3(funcObjetivo, [rmin, titamin], [rmax,titamax], 10000, 1, false);
%         opcNumerico =  [1000, 0.0001, 0, 0.5, 0.5];
%         argmin=a1(funcObjetivo, x0, 1, opcNumerico, funcObjetivo);
        gradFuncObjetivo = @(x) gradNum(funcObjetivo,x);
        argmin = armijo(funcObjetivo, xCero, 0.5, 0.5, gradFuncObjetivo, 0.00001, 10000);
        currentMax = areaPoligono(argmin, cantVertices)
        xCero = argmin;
        currentArgMax = argmin;
    end
    % Ploteamos el resultado
    rs = currentArgMax(1:cantVertices);
    titas = currentArgMax(cantVertices+1:2*cantVertices);
    x = [0, rs.*cos(titas),0];
    y = [0, rs.*sin(titas),0]; 
    
    plot(x,y);
    title(['N=', num2str(cantVertices+1), ' ', '- Gradiente'])
    legend(strcat('Regular: ', num2str(areaRegular)), strcat('Obtenido: ', num2str(currentMax)))
    % Área del polígono minimizador
    currentArgMax
    out = currentMax;
end