function [x,fx] = a13(f, xmin, xmax, N, epsilon, plotear)
    % Descenso Aleatorio con Búsqueda local iterada
    n = size(xmin,2);
    bestx = (xmin+xmax)/2;  % Empezamos en el centro del rectángulo
    best = f(bestx);
    
    y = 1:N;
    
    for i = 1:N     % Cuántos reinicios.
        x0 = rand(1,n).*(xmax-xmin) + xmin;     % Punto al azar en el dom.
        [x,fx] = a12(f,xmin, xmax, N/10, epsilon, x0, 1);
        if fx < best
            bestx = x;
            best = fx;
        end
        y(i) = fx;
    end
    
    x = bestx;
    fx = best;
    if plotear
        plot(1:N, y);
    end;
end
