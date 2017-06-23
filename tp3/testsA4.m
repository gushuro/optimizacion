%% tests para recocido simulado super cheto

f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

%a4(f1, [0,0], [1,1], 10000, 1 )

%x1 = a4(f2, ones(1,7)*-2.048,ones(1,7)*2.048, 10000, 1 )
x2 = a4(f2, ones(1,7)*-2.048,ones(1,7)*2.048, 1000, 100,1 )


%%
metodoGradiente(f2, [1,2], 2, [100000, 0.001, 0], f2);