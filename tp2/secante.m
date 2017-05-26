function secante = secante (f, x, gradiente, a0, a1)
    d = -gradiente(x);
    alphacero = a0;
    alphauno = a1;
    phi = @(t) f(x+t*d);
    dphi = @(t) gradiente(x+t*d)*d';
    for j = 1:100
        alphaNuevo = alphauno - dphi(alphauno)*(alphauno - alphacero)/(dphi(alphauno) - dphi(alphacero));
        alphacero=alphauno;
        alphauno=max(alphaNuevo,0);
        if abs(alphauno - alphacero) < 0.001
            break;
        end
    end
    secante = alphauno;
end