function [x, fx] = a12(f, xmin, xmax, N, epsilon, x0, plotear)
    % Descenso Aleatorio con Búsqueda local
    n = size(xmin,2);
    bestx = x0; %(xmin+xmax)/2;  % Empezamos en el centro del rectángulo
    best = f(bestx);
    y = 1:N;
    for i = 1:N
        intmin = max(xmin, bestx-epsilon);
        intmax = min(xmax, bestx+epsilon);
        a = rand(1,n).*(intmax-intmin) + intmin;
        if f(a) < best
            bestx = a;
            best = f(a);
        end
        y(i) = best;
    end
    x = bestx;
    fx = best;
    
    if plotear
        plot(1:size(y,2), y);
    end
end
