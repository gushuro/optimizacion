function armijo = armijo(f,x0,alpha,theta,gradiente, tolGrad, N)

    x = x0;
    
    for i = 1:3000 % cambiar por MaxNumIter ???????
        lambda = 1;
        gradEnx = gradiente(x); 
        d = (-theta)*gradEnx;   % elegimos d asi para que cumpla lo pedido
        if (norm(gradEnx) < tolGrad)
            break;
        end
        while f(x + lambda*d) > f(x) + lambda*alpha*(gradEnx*d')
            lambda = 0.5*lambda;
            if lambda < 0.00001
                break;
            end
        end
        x = x + lambda*d;
        if lambda < 0.00001
            break;
        end
    end
    
    armijo = x;

end