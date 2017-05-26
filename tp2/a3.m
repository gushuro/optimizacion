function a3 = a3(f, x0, opciones, gradiente)

    % opciones=[MaxNumIter, tolGrad, tolIter, gradHess]
    n = size(x0,2);       % Dimensión del dominio de la función
    N = opciones(1);    % Cantidad de Iteraciones
    tolGrad = opciones(2);  %
    tolIter = opciones(3);  %
    gradHess = opciones(4); %
   
    if (~gradHess)
        gradiente=@(x) gradNum(f,x);
    end
    
    x = x0;

    for i = 1:N
        i;
        g = gradiente(x);
        d = -g;
        % Criterio de parada: Si la norma del gradiente es pequeña.
        if (norm(d) < tolGrad)
            break;
        end
        
        % metodo de la secante
        T = secante(f, x, gradiente, 0, 1);
        x = x - T*g;
    end
    a3 = x
   
    f(x)
end
    
    %xsurf = -1:0.05:1;

    %[X,Y] = meshgrid(xsurf,xsurf);

    %Z = f(X,Y);

    %surf(X,Y, Z);
    %hold on;
    %plot(x,y, 'r+:');
  