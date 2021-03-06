function [x,fx] = recocidoSimulado(f, xmin, xmax, N, T, xCero)  
    %RECOCIDO SIMULADO v2.0
    n = size(xmin,2)/2;
    bestR = xCero(1:n);
    bestTita = xCero(n+1:2*n);
    bestx = [bestR, bestTita];
    best = f(bestx);
    actualx = bestx;
    actual = best;
    Tinicial = T;
    initialSigma = (xmax-xmin)/3;
    
    stepsWithoutImprovement = 0;    %Guardamos cantidad de iteraciones sin mejora global
    iterationsSinceReset = 0;       %Guardamos cantidad de iteraciones desde el último reset.
    
    recorridos = zeros(2,N+1);
    y = 1:(N+1);

    for i = 1:N
        %actualx    %% Descomentar para ir viendo la evolución de x.
        %pause(0.001)
        
    % A medida que avanzamos, además de reducir la temperatura disminuimos
    % El entorno donde buscamos el próximo x.
        a = actualx + randn(1,2*n).*initialSigma/(iterationsSinceReset+10);
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
        
        
        % Para graficar ------
        y(i) = actual;
        % Para graficar ------
        
        
        
        % Además, si el nuevo punto es globalmente el mejor encontrado,
        % realizamos un pequeño método de descenso desde ese punto
        if actual < best && iterationsSinceReset > 100 
            % log(N) iteraciones de método del gradiente.
            %actualx = metodoGradiente(f, actualx, 2, [log(N), 0.001, 0], f, xmin, xmax);
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
        
        % Si por acá no estamos viendo mejoras, reiniciamos. Esto, a lo 
        % sumo 20 veces.
        if stepsWithoutImprovement > N/20
            actualR = rand(1,n).*(xmax(1:n)-xmin(1:n)) + xmin(1:n);
            actualTita = sort(rand(1,n).*(xmax(n+1:2*n)-xmin(n+1:2*n)) + xmin(n+1:2*n));
            actualx = [actualR, actualTita];
            actual = f(actualx);
            iterationsSinceReset = 0;
            stepsWithoutImprovement = 0;
            T = Tinicial;
        else
            iterationsSinceReset = iterationsSinceReset + 1;
        end
    end

    x = bestx;
    fx = best;
    %[x,fx] = metodoGradiente(f, bestx, 4, [100, 0.001, 0. 0.5, 0.5], f, xmin, xmax)
end
