%% Acá testeamos el A1
% a11
f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);


[x,fx] = a11(f1,[0,0],[1,1],10000,1)

%% a12

[x,fx] = a12(f1,[0,0],[1,1],10000, 0.1, [0.5,0.5],1)

%% a13

a13(f1,[0,0],[1,1],10000, 0.01,1)


a13(f2,ones(1,2)*-2.048,ones(1,2)*2.048,1000, 0.1,1)



%% otras funciones: bird

addpath('testFunctions/single-objective/')


[x,fx] = a11(@bird,[-2*pi,-2*pi],[2*pi,2*pi],10000,1)
[x,fx] = a12(@bird,[-2*pi,-2*pi],[2*pi,2*pi],10000, 0.5, [0,0],1)
[x,fx]= a13(@bird,[-2*pi,-2*pi],[2*pi,2*pi],10000, 0.5,0)

%% otras funciones: eggholder

addpath('testFunctions/single-objective/')

%[x,fx] = a11(@eggholder,[-512,-512],[512,512],10000,1)
[x,fx] = a12(@eggholder,[-512,-512],[512,512],10000, 1, [0,0],1)
%[x,fx] = a13(@eggholder,[-512,-512],[512,512],1000, 1,0)

%% otras funciones: giunta

addpath('testFunctions/single-objective/')

%[x,fx] = a11(@giunta,[-1,-1],[1,1],10000,1)  % anda hermoso
%[x,fx] = a12(@giunta,[-1,-1],[1,1],10000, 0.1, [0,0],1) %anda hermoso
[x,fx] = a13(@giunta,[-1,-1],[1,1],1000, 0.1,0) % anda hermoso