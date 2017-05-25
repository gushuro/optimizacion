function a2 = a2(f, x0, opciones, gradiente, hessiano) % f es cuadrática: 1/2*x'*Q*x - b'*x
    % opciones=[MaxNumIter, tolGrad, gradHess, alpha, theta]
    n = size(x0,2);       % Dominio de la función
    N = opciones(1);    % Cantidad de Iteraciones
    tolGrad = opciones(2);  % Tolerancia para la norma del gradiente
    gradHess = opciones(3); % Variable binaria que indica si el gradiente o Hessiano son datos (1) o hay que calcularlos numéricamente (0).
    if (~gradHess)
        gradiente = @(x) gradNum(f,x);
        hessiano  = @(x) hessNum(f,x);
    end
    x = x0;
    Q = hessiano(zeros(1,n));
    b = -gradiente(zeros(1,n))';
    g = Q*x' - b;
    d = -g;

    for i = 1:n
        i;
        alpha = (-g'*d)/(d'*hessiano(x)*d);
        x = x + alpha *d';
        g = Q*x'-b;
        beta = (g'*Q*d)/(d'*Q*d);
        d = -g + beta*d;
        % Un criterio de parada: Si la norma del gradiente es pequeña.
        if (norm(d) < tolGrad)
            break;
        end
    end
    a2 = x
end
