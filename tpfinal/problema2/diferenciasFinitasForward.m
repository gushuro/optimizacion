function out = diferenciasFinitasForward(x, y)
    % 
    n = size(x,2);
    h = x(2)-x(1);
    res = zeros(size(x));
    y = [y(1),y, y(n)];
    res(1) = (y(2)-y(1))/h;
    res(n) = (y(n+1)-y(n))/h;
    for i = 1:n
        yMenos = y(i+1);
        yMas = y(i);    
        res(i) = (yMas - yMenos)/h;
    end
    out = res;
end