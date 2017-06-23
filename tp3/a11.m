function [x,fx] = a11(f, xmin, xmax, N, plotear)
    % Descenso Aleatorio con descenso más rápido.
    n = size(xmin,2);
    
    bestx = xmin;
    best = f(bestx);
    y = zeros(1,N);
    for i = 1:N
        a = rand(1,n).*(xmax-xmin) + xmin;
        if f(a) < best
            bestx = a;
            best = f(a);
        end
        y(i) = f(a);
    end
    x = bestx;
    fx = best;
    if plotear
        plot(1:size(y,2), y)
    end
end
