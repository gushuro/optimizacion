function out = diferenciasFinitas(x, y)
    % Calcula integral de y(x) aproximando con trapecios
    n = size(x,2);
    h = x(2)-x(1);
    res = zeros(size(x));
    res(1) = (y(2)-y(1))/h;
    res(n) = (y(n)-y(n-1))/h;
    for i = 2:n-1
        yMenos = y(i-1);
        yMas = y(i+1);    
        res(i) = (yMas - yMenos)/(2*h);
    end
    out = res;
end