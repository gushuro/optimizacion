function a1 = a1(f, x0, busquedaLineal, opciones, gradiente)
    % busquedaLineal es el metodo para buscar el minimo de phi (en los primeros tres casos):
    %   1 == fminsearch
    %   2 == fminbnd
    %   3 == grado 0
    %   4 == inexacta (Armijo)
        
    % opciones=[MaxNumIter, tolGrad, tolIter, gradHess, alpha, beta, theta]
    n = size(x0);       % Dominio de la función
    N = opciones(1);    % Cantidad de Iteraciones
    tolGrad = opciones(2);  %
    tolIter = opciones(3);  %
    gradHess = opciones(4); %
   
    if (~gradHess)
        %gradiente = gradNumerico;
        gradiente=@(x) gradNum(f,x);
    end
        
    
    %f = @(x,y) (x-y).^4 + 2*x.^2 + y.^2 - x + 2*y;

    x = x0;
    if (busquedaLineal == 4)
        armijo
    else
        
        for i = 1:N
            i
            g = gradiente(x);
            d = -g;
            %phi= @(t) f(x+t*d);
            % Criterio de parada: Si la norma del gradiente es pequeña.
            if (norm(d) < tolGrad)
                break;
            end
            if (busquedaLineal == 1)
                T = fminsearch(@(t) f(x+t*d), 0);  %% TIRA ERROR
            elseif (busquedaLineal == 2)
                T = fminsearch(@(t) f(x+t*d), 0); %% TIRA ERROR
            else
                T = triseccion(0,80000,f,x,d); %% PARECE ANDAR BIEN
            end
        
            x = x - T*g;
       % x(i+1) = x(i)-T*g(1);
       % y(i+1) = y(i)-T*g(2);
        end
    end
    
    %xsurf = -1:0.05:1;

    %[X,Y] = meshgrid(xsurf,xsurf);

    %Z = f(X,Y);

    %surf(X,Y, Z);
    %hold on;
    %plot(x,y, 'r+:');
end