function a3 = a3(f, xmin, xmax, N, T, plotear)  
    %RECOCIDO SIMULADO
    
    n = size(xmin,2);   
    bestx = xmin;
    best = f(bestx);
    actualx = bestx;
    actual = best;
    
    y = 1:N;
    
    for i = 1:N
        %a = rand(1,n).*(xmax-xmin) + xmin;
        a = actualx + randn(1,n)
        a = min(a, xmax)
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
        y(i) = actual;
        if actual < best
            bestx = actualx;
            best = actual;
        end
        T=T*0.99;
    end
    a3 = bestx;
    
    if plotear
        plot(1:N, y)
        set(gca, 'YScale', 'log')
    end
end
