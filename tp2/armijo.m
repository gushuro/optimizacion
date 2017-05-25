
function armijo = armijo(f,x0,alpha,theta,gradiente)

    x = x0;
    lambda = 1;
    
    for i = 1:3000 % cambiar por MaxNumIter ???????
        gradEnx = gradiente(x); 
        d = (-theta)*gradEnx;   % elegimos d asi para que cumpla lo pedido
        while f(x + lambda*d) > f(x) + lambda*alpha*(gradEnx*d')
            lambda = 0.5*lambda;
        end
        x = x + lambda*d;
    end
    
        armijo = x;

end