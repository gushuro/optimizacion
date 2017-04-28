function [h1,h2,h3] = ej2_TP(x,y,b0,k0,c0)
    N = size(x,1);
    tita = [b0,k0,c0];
    cantIteraciones = 5000;
    tolerancia = 10^-5;
    
    for i = 1:cantIteraciones
        b = tita(1);
        k = tita(2);
        c = tita(3);

        J = [-k*(exp(b*x).*x), -(exp(b*x)), -ones(N,1)];
        d = y - k*exp(b*x) - c;
        [Q,R] = qr(J);
        h = R\(Q'*(-d));
        
        tita = tita + h';
        if (norm(h) < tolerancia)
            break;
        end
    end
    h1 = h(1);
    h2 = h(2);
    h3 = h(3);
    
    xplotear = min(x):0.1:max(x);
    plot(x,y,'.')
    hold on;
    plot(xplotear, tita(2) * exp(tita(1)*xplotear) + tita(3));
    hold off;
    
    fprintf('La exponencial hallada fue %.2fe^%.2fx + %.2f \n',tita(1), tita(2), tita(3));
end