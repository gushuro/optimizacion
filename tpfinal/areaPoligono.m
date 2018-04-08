function f = areaPoligono(r0, tita0, cantVertices)
    sum = 0;
    for i = 1:cantVertices-1
        sum = sum + r0(i+1)*r0(i)*sin(tita0(i+1)-tita0(i))
    end
    f = (1/2)*sum - 1000 % blabla
    
    
    % ver como penalizar f.o. con las restricciones


end
