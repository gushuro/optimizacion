function out = integralTrapecios(x, y)
    % Calcula integral de y(x) aproximando con trapecios
    n = size(x,2);
    res = 0;
    for i = 1:n-1
        x1 = x(i);
        x2 = x(i+1);
        y1 = y(i);
        y2 = y(i+1);
        res = res + (x2-x1)*(y2+y1)/2;
    end
    out = res;
end