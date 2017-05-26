
function gradNum = gradNum(f,x)
    n = size(x,2);
    h = 0.000001;
    grad = zeros(1,n); % vector fila de ceros
    A = eye(n);
    for i = 1:n
        ei = A(i,:); % i-esimo canonico
        grad(i) = (f(x + h*ei) - f(x))/h; %Calculo las derivadas parciales
    end
    gradNum = grad;
end