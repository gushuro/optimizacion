%% Acá testeamos el A1
f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

a2(f2,ones(1,7)*-2.048,ones(1,7)*2.048,10000,10,1)