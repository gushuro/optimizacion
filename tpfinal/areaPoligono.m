function f = areaPoligono(x, cantVertices)
% Calcula el area de un polígono con un vértice en el (0,0) y los restantes
% cantVertices en coordenadas polares. X contiene primero los radios y
% luego los ángulos
    r = x(1:cantVertices);
    tita = x(cantVertices+1:2*cantVertices);
    sum = 0;
    for i = 1:cantVertices-1
        sum = sum + r(i+1)*r(i)*sin(tita(i+1)-tita(i));
    end
    f = (1/2)*sum;
end
