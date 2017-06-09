function [x, fx] = a12(f, xmin, xmax, N, epsilon, x0)
    n = size(xmin,2);
    bestx = x0; %(xmin+xmax)/2;  % Empezamos en el centro del rectángulo
    best = f(bestx);
    
    for i = 1:N
        intmin = max(xmin, bestx-epsilon);
        intmax = min(xmax, bestx+epsilon);
        a = rand(1,n).*(intmax-intmin) + intmin;
        if f(a) < best
            bestx = a;
            best = f(a);
        end
    end
    x = bestx;
    fx = best;
end
