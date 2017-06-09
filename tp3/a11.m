function a11 = a11(f, xmin, xmax, N)
    n = size(xmin,2);
    
    bestx = xmin;
    best = f(bestx);
    
    for i = 1:N
        a = rand(1,n).*(xmax-xmin) + xmin;
        if f(a) < best
            bestx = a;
            best = f(a);
        end
    end
    a11 = bestx;
end
