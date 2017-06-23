%% tests para recocido simulado

f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);


a3(f1, [0,0], [1,1], 10000, 1, 1)

a3(f2, ones(1,2)*-2.048,ones(1,2)*2.048, 100, 100, 1 )  % 100 iteraciones, T=100


%%
metodoGradiente(f2, [1,2], 2, [100000, 0.001, 0], f2);

%% 
t = zeros(1,2);
tic
a3(f1, [0,0], [1,1], 10000, 100, 1);
t(1,1) = toc;
tic
a3(f2, ones(1,4)*-2.048,ones(1,4)*2.048, 10000, 100, 1)
t(1,2) = toc;
t