function a3 = a3(f, xmin, xmax, N, T)  %RECOCIDO SIMULADO
    n = size(xmin,2);   
    bestx = xmin;
    best = f(bestx);
    actualx = bestx;
    actual = best;
    for i = 1:N
        %a = rand(1,n).*(xmax-xmin) + xmin;
        actualx
        a = actualx + randn(1,n)*10/i
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
        
        if actual < best
            bestx = actualx;
            best = actual;
        end
        %T=T*0.99;
        
        if mod(i,5)
            T = T*0.985;
        end
    end
    a3 = bestx;
end
