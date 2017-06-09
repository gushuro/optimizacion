function rosen = rosen(x)
    n = size(x,2);
    rosen = 0;
    for i = 1:(n-1)
        rosen = rosen + (1-x(i))^2 + 100 * (x(i+1)-x(i)^2)^2;
    end
end
