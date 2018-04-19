function pen = penalizacion(x, cantVertices)
    r = x(1:cantVertices);
    tita = x(cantVertices+1:2*cantVertices);
    penalizacionDiametro = 0;
    
    % Primero penalizamos diametro > 1
    for i=1:cantVertices
        for j=i+1:cantVertices
            dif = r(i)^2 + r(j)^2 - 2*r(i)*r(j)*cos(tita(i)-tita(j)) - 1;
            % Si hay dos vértices a distancia mayor a 1, penalizar
            if dif > 0
                penalizacionDiametro = penalizacionDiametro + dif^2;
            end
        end
        dif = r(i)^2 - 1;
        if dif > 0 
            penalizacionDiametro = penalizacionDiametro + dif^2;
        end
    end
    
    
    % Los vértices tienen que estar ordenados
    penAngulos = 0;
    for i=1:cantVertices-1
        dif = tita(i) - tita(i+1);
        if dif > 0
            penAngulos = penAngulos + dif^2;
        end
    end
    
    % Titas y r en dominio
    penDominio = 0;
    for i= 1:cantVertices
        if tita(i) < 0
            penDominio = penDominio + tita(i)^2;
        elseif tita(i) > pi
            penDominio = penDominio + (tita(i) - pi)^2;
        end
        if r(i) < 0
            penDominio = penDominio + r(i)^2;
        end
    end
    pen = penalizacionDiametro + penAngulos + penDominio;
    
end