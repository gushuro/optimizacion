function [x,fx] = a2(f, xmin, xmax, N, popsize, plotear)
    % Algoritmo Genético
    resto = mod(popsize,4);
    if resto > 0
        popsize = popsize + 4 - resto; % Completamos para que sea múltiplo de 4.
    end
    n = size(xmin,2);    
    P = zeros(popsize,n+1);
    mitad = popsize/2;
    cuarto = mitad/2;
    
    
    
    % Inicializamos la poblacion
    % Primero, con una partición uniforme del rectángulo
    for i = 1:n
        P(:,i) = linspace(xmin(i), xmax(i), popsize);
    end
    % Y perturbamos un poco
    P(:,1:n) = P(:,1:n) + randn(popsize, n)/10;
    
    
    %Precalculamos f en la población inicial
    for i = 1:popsize
        P(i,n+1) = f(P(i,1:n));
    end
    
    
    y = 1:N;
    
    P = sortrows(P,n+1);    % Esto no es optimo. Pero a Agu le gusta. Mucho.
    bestx = P(1,1:n);
    best = P(1,n+1);
    for j = 1:N
        for i = 1:cuarto
            padre1 = P(i,1:n);
            padre2 = P(mitad-i+1,1:n);
            %padre1 = P(i,1:n);
            %padre2 = P(i+1, 1:n);
            [hijo1, hijo2] = crossover(padre1, padre2);
            hijo1 = mutar(hijo1, xmin, xmax);
            hijo2 = mutar(hijo2, xmin, xmax);
            P(mitad+2*i-1, :) = [hijo1, f(hijo1)];
            P(mitad+2*i, :) = [hijo2, f(hijo2)];
        
        end
        P = sortrows(P,n+1);
        y(j) = P(1,n+1);
        %Aca, si mutamos a los padres, hay que actualizar best
        
        %if P(1,n+1) > best
        %    bestx = P(1,1:n);
        %    best = P(1,n+1);
        %end
    end
    x  = P(1,1:n  );
    fx = P(1,1:n+1);
    
    if plotear
        plot(1:N, y);
    end
    
end