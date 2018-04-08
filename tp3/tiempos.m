%% Testeamos tiempos. 

f1 = @(x) (x(1)-0.5)^2+(x(2)-0.75)^2;
f2 = @(x) rosen(x);

%% tiempos A1
% En la fila i, el método i para ambas funciones

t = zeros(3,2);
tic
a11(f1,[0,0],[1,1],100000,0);
t(1,1) = toc
tic
a11(f2,-2.048*ones(1,4),2.048*ones(1,4),100000,0);
t(1,2) = toc
tic 
[x,fx] = a12(f1,[0,0],[1,1],100000, 0.1, [0.5,0.5],0);
t(2,1) = toc
tic
[x,fx] = a12(f2,-2.048*ones(1,4),2.048*ones(1,4),100000, 0.1, 0.5*ones(1,4),0);
t(2,2) = toc
tic
a13(f1,[0,0],[1,1],1000, 0.1,0);
t(3,1) = toc
tic
a13(f2,ones(1,4)*-2.048,ones(1,4)*2.048,1000, 0.1,0);
t(3,2) = toc

t

%% Tiempos A2 A3 A4

t2 = zeros(3,2);
tic
a2(f1,[0,0],[1,1],100000,40, 0);
t2(1,1) = toc
tic
a2(f2,-2.048*ones(1,4),2.048*ones(1,4),100000,40,0);
t2(1,2) = toc
tic 
a3(f1, [0,0], [1,1], 100000, 100, 0);
t2(2,1) = toc
tic
a3(f2, ones(1,4)*-2.048,ones(1,4)*2.048, 100000, 100, 0)
t2(2,2) = toc
tic
a4(f1, [0,0], [1,1], 100000, 100,0);
t2(3,1) = toc
tic
a4(f2, ones(1,4)*-2.048,ones(1,4)*2.048, 100000, 100, 0);
t2(3,2) = toc