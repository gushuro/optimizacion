function metodoGradiente = metodoGradiente(f, x0, busquedaLineal, opciones, gradiente)
    % busquedaLineal nos permite elegir el metodo para buscar el minimo de 
    % phi (en los primeros tres casos). El metodo de Armijo minimiza f de
    % otra forma.
    
    %   1 == fminsearch
    %   2 == fminbnd
    %   3 == grado 0
    %   4 == inexacta (Armijo)
        
    % opciones=[MaxNumIter, tolGrad, gradHess, alpha, theta]
    
    n = size(x0,2);       % Diemnsión del dominio de la función
    N = opciones(1);    % Cantidad de Iteraciones
    tolGrad = opciones(2);  % Tolerancia para la norma del gradiente
    gradHess = opciones(3); % Variable binaria que indica si el gradiente o es dato (1) o hay que calcularlo numéricamente (0).
    
   
    if (~gradHess)
        gradiente=@(x) gradNum(f,x);
    end

    x = x0;
    if (busquedaLineal == 4)
        alpha = opciones(4);
        theta = opciones(5);
        x= armijo(f, x, alpha, theta, gradiente, tolGrad, N); 
    else
        for i = 1:N
            g = gradiente(x);
            d = -g;
           
            % Un criterio de parada: Si la norma del gradiente es pequeña.
            if (norm(d) < tolGrad)
                break;
            end
            
            if (busquedaLineal == 1)
                T = fminsearch(@(t) f(x+t*d), 0);  
            elseif (busquedaLineal == 2)
                T = fminbnd(@(t) f(x+t*d), 0, 1); 
            else
                T = triseccion(0,10000,f,x,d);
            end
        
            x = x - T*g;
      
        end
    end
    
    %xsurf = -1:0.05:1;

    %[X,Y] = meshgrid(xsurf,xsurf);

    %Z = f(X,Y);

    %surf(X,Y, Z);
    %hold on;
    %plot(x,y, 'r+:');
    metodoGradiente = x;
   
    f(x)
end