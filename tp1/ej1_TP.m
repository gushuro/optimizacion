function [a,k] = ej1_TP(x,y)
    if max(abs(y))==max(y) % transforma los positivos o los negativos en ceros, depende del signo del maximo (en valor absoluto) de y
        x = x.*(y>0);   % truncamos a 0 las filas de [x,y] cuyos valores en y son negativos.
        y = y.*(y>0);
        exit=1;
    else
        x = x.*(y<0);   % ídem positivos
        y = y.*(y<0);
        exit=2;
    end
    x(all(~x,2),:) = []; % Vuela los ceros del vector x
    y(all(~y,2),:) = []; % Vuela los ceros de vector y
    if exit==1
        b = log(y);
    else
        b=log(-y);
    end
    
    N = size(x,1);
    A = [ones(N,1), x];
    
    [Q,R] = qr(A'*A);
    res = R\(Q'*A'*b);          % Resolvemos
    
    a = exp(res(2));
    if exit==1
        k = exp(res(1));  
    else
        k = -exp(res(1));
    end

    z = y-k*a.^x;
    norma = norm(z)
    xposta = min(x):0.1:max(x);
    plot(x,y,'.')               % Graficamos los datos
    hold on;
    plot(xposta,k*(a.^xposta))  % Graficamos la curva encontrada
    hold off;
end
