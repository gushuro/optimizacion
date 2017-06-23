function [x,fx] = a4(f, xmin, xmax, N, T, plotear)  
    %RECOCIDO SIMULADO v2.0
    n = size(xmin,2);   
    bestx = xmin;       % Tomamos como x0 a xmin.
    best = f(bestx);
    actualx = bestx;
    actual = best;
    Tinicial = T;
    
    stepsWithoutImprovement = 0;        %Guardamos cantidad de iteraciones sin mejora global
    iterationsSinceReset = 0;            %Guardamos cantidad de iteraciones desde el último reset.
    
    y = 1:(N+1);
    
    for i = 1:N
        actualx;    %% Descomentar para ir viendo la evolución de x.
        
    % A medida que avanzamos, además de reducir la temperatura disminuimos
    % El entorno donde buscamos el próximo x.
        a = actualx + randn(1,n)*10/(iterationsSinceReset+10)   
        a = min(a, xmax);   %Bound checks
        a = max(a, xmin);   %Bound checks
        
        if f(a) < actual    %Si el nuevo punto es mejor, me muevo
            actualx = a;
            actual = f(a);
        else            % si el nuevo punto es peor que el que teniamos, aceptarlo con una probabilidad sugerida p 
            p = exp((actual - f(a))/T); 
            if rand < p % la proba de que rand sea menor a p es justamente p
                actualx = a;
                actual = f(a);
            end
        end
        
        y(i) = actual;
        
        % Además, si el nuevo punto es globalmente el mejor encontrado,
        % realizamos un pequeño método de descenso desde ese punto
        if actual < best
            % log(N) iteraciones de método del gradiente.
            actualx = metodoGradiente(f, actualx, 2, [log(N), 0.001, 0], f);
            actual = f(actualx);
            bestx = actualx;
            best = actual;
            stepsWithoutImprovement = 0;
        else
            stepsWithoutImprovement = stepsWithoutImprovement + 1;
        end
        %T=T*0.99;
        
        %Cada 10 iteraciones, disminuimos un poco la temperatura.
        if mod(i,10)
            T = T*0.985;
        end
        
        % Si por acá no estamos viendo mejoras, reseteamos. Esto, a lo sumo
        % 20 veces.
        if stepsWithoutImprovement > N/20
            actualx = rand(1,n).*(xmax-xmin) + xmin
            actual = f(actualx);
            iterationsSinceReset = 0;
            stepsWithoutImprovement = 0;
            T = Tinicial;
        end
    end
    bestx
    best
    
    % Podríamos terminar acá. Pero, en vez de quedarnos con el mejor punto
    % encontrado, buscamos un mínimo local cercano a él. 
    [x,fx] = metodoGradiente(f, bestx, 2, [N/10, 0.001, 0], f);
    y(N+1) = fx;
    if plotear
        plot(1:(N+1), y)
        set(gca, 'YScale', 'log')
    end
    xsurf = xmin(1):0.01:xmax(1);
    ysurf = xmin(2):0.01:xmax(2);
    
    [X,Y] = meshgrid(xsurf,xsurf);
    Z = X;
    
    for i = 1:size(X,1)
        for j = 1:size(X,2)
            Z(i,j) = f([X(i,j),Y(i,j)]);
        end
    end

    surf(X,Y, Z);
    hold on;
    %plot(x,y, 'r+:');
end
