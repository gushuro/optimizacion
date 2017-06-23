function a4 = a4(f, xmin, xmax, N, T)  %RECOCIDO SIMULADO
    n = size(xmin,2);   
    bestx = xmin;       % Tomamos como x0 a xmin.
    best = f(bestx);
    actualx = bestx;
    actual = best;
    Tinicial = T;
    
    stepsWithoutImprovement = 0;        %Guardamos cantidad de iteraciones sin mejora global
    iterationsSinceReset = 1            %Guardamos cantidad de iteraciones desde el último reset.
    
    
    for i = 1:N
        actualx;
        
        a = actualx + randn(1,n)*10/(iterationsSinceReset+10)
        a = min(a, xmax);
        a = max(a, xmin);
        if f(a) < actual
            actualx = a;
            actual = f(a);
        else            % si el nuevo punto es peor que el que teniamos, aceptarlo con una probabilidad sugerida p 
            p = exp((actual - f(a))/T); 
            if rand < p % la proba de que rand sea menor a p es justamente p
                actualx = a;
                actual = f(a);
            end
        end
        
        if actual < best
            actualx = metodoGradiente(f, actualx, 2, [sqrt(N), 0.001, 0], f);
            actual = f(actualx);
            bestx = actualx;
            best = actual;
            stepsWithoutImprovement = 0;
        else
            stepsWithoutImprovement = stepsWithoutImprovement + 1;
        end
        %T=T*0.99;
        
        if mod(i,5)
            T = T*0.985;
        end
        
        % Si por acá no mejora, reseteamos. A lo sumo 20 veces.
        if stepsWithoutImprovement > N/20
            actualx = rand(1,n).*(xmax-xmin) + xmin
            actual = f(actualx);
            iterationsSinceReset = 1;
            T = Tinicial;
        end
    end
    bestx
    best
    a4 = metodoGradiente(f, bestx, 2, [N/10, 0.001, 0], f);
end
