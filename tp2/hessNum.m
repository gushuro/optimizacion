
function hessNum = hessNum(f,x)
    n = size(x,2);
    h = 0.0001;
    hess = zeros(n); % vector fila de ceros
    A = eye(n);
    for i = 1:n
        for j = 1:n
            ei = A(i,:); % i-esimo canonico
            ej = A(j,:);
            hess(i,j) = (f(x) + f(x + h*ei + h*ej) - f(x + h*ei)-f(x + h*ej))/h^2; %Calculo las derivadas parciales
        end
    end
    hessNum = hess;
end