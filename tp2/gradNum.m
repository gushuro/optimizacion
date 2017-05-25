function gradNum = gradNum(f,x)
    n = size(x,2);
    h = 0.000001;
    grad = zeros(1,n); % vector fila de ceros
    for i = 1:n
        z = x;
        x(i) = x(i)+h;
        xIncrementadoEni = x;
        grad(i) = (f(xIncrementadoEni) - f(z))/h; %Calculo las derivadas parciales
        x = z;
    end
    gradNum = grad;
end