function mutar = mutar(individuo, xmin, xmax)
    sigma = (xmax-xmin)/15;
    n = size(individuo,2);
    mutar = individuo + randn(1,n).*sigma;
    mutar(4) = xmin(4) + rand * (xmax(4)-xmin(4));
    mutar = min(mutar, xmax);
    mutar = max(mutar, xmin);
end