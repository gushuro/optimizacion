function a2 = a2(f, xmin, xmax, N, popsize)
    resto = mod(popsize,4);
    if resto > 0
        popsize = popsize + 4 - resto; % Completamos para que sea múltiplo de 4.
    end
    n = size(xmin,2);    
    P = zeros(popsize,n+1);
    mitad = popsize/2;
    cuarto = mitad/2;
    
    
    
    %Inicializamos la poblacion
    for i = 1:n
        P(:,i) = linspace(xmin(i), xmax(i), popsize);
    end
    
    %Precalculamos f en la población inicial
    for i = 1:popsize
        P(i,n+1) = f(P(i,1:n));
    end
    
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
        P(1:10, :)
        %Aca, si mutamos a los padres, hay que actualizar best
        
        %if P(1,n+1) > best
        %    bestx = P(1,1:n);
        %    best = P(1,n+1);
        %end
    end
    a2 = P(1,1:n);
end