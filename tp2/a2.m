a2 = a2(f,x0,opciones, gradiente) % f es cuadrática: 1/2*x'*Q*x - b'*x
    % opciones=[MaxNumIter, tolGrad, tolIter, gradHess, alpha, beta, theta]
    n = size(x0);       % Dominio de la función
    N = opciones(1);    % Cantidad de Iteraciones
    tolGrad = opciones(2);  %
    tolIter = opciones(3);  %
    gradHess = opciones(4); %
    if (~gradHess)
        gradiente=@(x) gradNum(f,x);
    end
    x = x0;    
    
    %f = @(x) (x(1)-x(2)).^4 + 2*x(1).^2 + x(2).^2 - x(1) + 2*x(2);

    for i = 1:N
            i;
            g = gradiente(x);
            d = b - Q*x
            % Criterio de parada: Si la norma del gradiente es pequeña.
            if (norm(d) < tolGrad)
                break;
            end