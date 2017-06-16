%% tests para recocido simulado

f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

a3(f1, [0,0], [1,1], 10000, 1 )

a3(f2, ones(1,2)*-2.048,ones(1,2)*2.048, 10000, 1 )