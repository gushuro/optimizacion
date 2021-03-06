function out = ej2(xa, xb, ya, yb, n, L)
% ej2 - Encuentra la curva formada por un hilo de masa constante a lo largo
% del horizonte, al ser colgada de dos extremos. 
%
% Syntax: out = ej2(-0.5,0.5, 4, 4, 300, 1.4)
% 
    close all;
    x = linspace(xa, xb, n);
    objFunction = @(y) integralTrapecios(x, [ya, y, yb]);
    
    nonlcon = @(y) constFunction(integralTrapecios(x, sqrt(1+diferenciasFinitas(x,[ya, y, yb]).^2)) - L);
    
    
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    lb = zeros(1,n-2);
    ub = ones(1,n-2)* max(ya,yb);
    y0 = linspace(ya, yb, n-2);
    options = optimoptions('fmincon');
    options.MaxFunctionEvaluations = 10000000;
    options.MaxIterations = 10000000;
    options.ConstraintTolerance = 10^-10;
    z = fmincon(objFunction,y0,A,b,Aeq,beq,lb,ub,nonlcon, options);

    out = [ya, z, yb];
    plot(x, out, 'blue')
    LongitudCuerda = integralTrapecios(x, sqrt(1+diferenciasFinitas(x,out).^2))
end