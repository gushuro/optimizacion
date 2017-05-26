function secante = secante (f, x, gradiente, a0, a1)
    d = -gradiente(x);
    alphacero = a0;
    alphauno = a1;
    phi = @(t) f(x+t*d);
    dphi = @(t) gradiente(x+t*d)*d';
    for j = 1:100
        alphaNuevo = alphauno - dphi(alphauno)*(alphauno - alphacero)/(dphi(alphauno) - dphi(alphacero));
        alphacero=alphauno;
        alphauno=alphaNuevo;
        if alphauno == alphacero
            break;
        end
    end
    secante = alphauno;
end