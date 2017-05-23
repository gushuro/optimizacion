function armijo = armijo(f,x0,alpha,theta,gradiente)

% NO LA LLEGUE A PROBAR


% gradiente es el gradiente si es dado, pero vale 0 si no lo dan.
x = x0;
%n = size(x0,2);
if gradiente == 0                    % si no me dan el gradiente, calcularlo numericamente
        gradiente = gradNum(f,x);
end
for i = 1:tolIter
    d = (-theta)*gradiente;   % elijo d asi para que cumpla lo pedido
    lambda = 1;
    while f(x + lambda*d) > f(x) + lambda*alpha*gradiente'*d
        lambda = 0,5*lambda
    end
    x = x + lambda*d
    gradiente = gradNum(f,x);
end
   armijo = x 
end
