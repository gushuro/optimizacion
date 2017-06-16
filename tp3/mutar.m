function mutar = mutar(individuo, xmin, xmax)
    sigma = (xmax-xmin)/20;
    n = size(individuo,2);
    mutar = individuo + randn(1,n).*sigma;
    mutar = min(mutar, xmax);
    mutar = max(mutar, xmin);
end