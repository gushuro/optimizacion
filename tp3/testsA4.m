%% tests para recocido simulado super cheto

f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

%a4(f1, [0,0], [1,1], 10000, 1 )

%x1 = a4(f2, ones(1,7)*-2.048,ones(1,7)*2.048, 10000, 1 )
x2 = a4(f2, ones(1,2)*-2.048,ones(1,2)*2.048, 5000, 100,2 )


%%
metodoGradiente(f2, [1,2], 2, [100000, 0.001, 0], f2);

%%

t = zeros(1,2);
tic
a4(f1, [0,0], [1,1], 10000, 100,1);
t(1,1) = toc;
tic
a4(f2, ones(1,4)*-2.048,ones(1,4)*2.048, 10000, 100, 1);
t(1,2) = toc;
t

%% otras funciones: bird

addpath('testFunctions/single-objective/')

xminbird = [-2*pi,-2*pi] + 0.001;        %% hay que cortar el borde
xmaxbird = -xminbird;
a4(@bird,xminbird, xmaxbird,1000,200,0)

%% otras funciones: eggholder

a4(@eggholder,[-512,-512],[512,512],10000,100,2) % da Nan :(

%% otras funciones: giunta

a4(@giunta,[-1,-1],[1,1],1000,100,0) % da Nan :(