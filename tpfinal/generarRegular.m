function [rs, titas] = generarRegular(n)
    % Primero lo generamos centrado en el origen, y con un vértice en el
    % eje Y.
    % Radio 1/2 para tener diámetro 1, y los titas uniformes, con el último
    % siendo el que está sobre el eje Y negativo.
    
    rs = ones(1,n-1)/2;
    titas = linspace(-pi/2,3/2*pi, n+1);
    titas = titas(2:n);
    xs = rs.*cos(titas);
    ys = rs.*sin(titas);
    
    % Lo movemos para que el último quede en el origen
    ys = ys + 0.5;
    %plot([xs,0, xs(1)], [ys,0, ys(1)]);
    xs
    ys
    rs = sqrt(xs.^2 + ys.^2)
    titas = atan(ys./xs)
    titas = mod(titas, pi)
    
    plot([rs.*cos(titas),0], [rs.*sin(titas),0])
end