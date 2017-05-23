function armijo = armijo(f,x0,alpha,theta,gradiente)

    % NO LA LLEGUE A PROBAR


    % gradiente es el gradiente si es dado, pero vale 0 si no lo dan.
    x = x0;
    %n = size(x0,2);

    for i = 1:1000 %cambiar por MaxNumIter
        gradEnx = gradiente(x); 
        d = (-theta)*gradEnx;   % elijo d asi para que cumpla lo pedido
        lambda = 1;
        while f(x + lambda*d) > f(x) + lambda*alpha*gradEnx'*d
            lambda = 0.5*lambda;
        end
        x = x + lambda*d;

    end
       armijo = x 
end
