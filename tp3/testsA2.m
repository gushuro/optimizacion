%% Acá testeamos el A2
f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

a2(f2,ones(1,4)*-2.048,ones(1,4)*2.048,10000,10,1)

%%

t = zeros(1,2);
tic
a2(f1,[0,0],[1,1],10000,200,1);
t(1,1) = toc;
tic 
a2(f2,ones(1,4)*-2.048,ones(1,4)*2.048,10000,200,1);
t(1,2)= toc;
t

%% otras funciones: bird

addpath('testFunctions/single-objective/')

[x,fx]= a2(@bird,[-2*pi,-2*pi],[2*pi,2*pi],10000,200,0)

%% otras funciones: eggholder

addpath('testFunctions/single-objective/')

[x,fx]= a2(@eggholder,[-512,-512],[512,512],1000,200,0) %anda 10 puntos, le baje las iteraciones a 1000 pq no terminaba mas

%% otras funciones: giunta

addpath('testFunctions/single-objective/')

[x,fx]= a2(@giunta,[-1,-1],[1,1],1000,200,0)  % HERMOSO