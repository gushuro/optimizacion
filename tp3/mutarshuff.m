function mutarshuff = mutarshuff(individuo, xmin, xmax)
    sigma = (xmax-xmin)/15;
    n = size(individuo,2);
    mutarshuff = individuo + randn(1,n).*sigma;
    mutarshuff(randperm(length(mutarshuff)));
    mutarshuff = min(mutarshuff, xmax);
    mutarshuff = max(mutarshuff, xmin);
end