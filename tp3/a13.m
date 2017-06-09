function a13 = a13(f, xmin, xmax, N, epsilon)
    n = size(xmin,2);
    bestx = (xmin+xmax)/2;  % Empezamos en el centro del rectángulo
    best = f(bestx);
    
    for i = 1:N     % Cuántos reinicios.
        x0 = rand(1,n).*(xmax-xmin) + xmin;     % Punto al azar en el dom.
        [x,fx] = a12(f,xmin, xmax, 1000, epsilon, x0);
        if fx < best
            bestx = x;
            best = fx;
        end
    end
    
    a13 = bestx;
end
