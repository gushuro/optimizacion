function out = ej1Gradiente(cantVertices)
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
    xCero = [rCero, titaCero];
    % CantVertices tendrá la cantidad de vértices no (0,0)
    cantVertices = cantVertices - 1;
    niter = 35;
    
    %r0 = ones(1,cantVertices);
    currentArgMax = [];
    currentMax = 0;
    print = ['El area del regular es: ', num2str(areaPoligono([rCero, titaCero], cantVertices))];
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
%         Ploteamos el resultado
%         rs = argmin(1:cantVertices)
%         titas = argmin(cantVertices+1:2*cantVertices)
%         x = [0, rs.*cos(titas),0];
%         y = [0, rs.*sin(titas),0];
%         plot(x,y)
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
%     plot(2*x,2*y);
%     plot(3*x,3*y);
%     plot(4*x,4*y);
    % Área del polígono minimizador
    out = currentMax;
end