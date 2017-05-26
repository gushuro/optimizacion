%% Funciones de ejemplo


f = @(x)(x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);
gf = @(x)[4*(x(1)-x(2)).^3+4*x(1)-1,(-4)*(x(1)-x(2)).^3+2*x(2)+2];

%Opciones para probar. Usa gradiente analítico/numérico
% opciones=[MaxNumIter, tolGrad, gradHess, alpha, theta]
opcAnalitico = [100, 0.001, 1, 0.5, 0.5];
opcNumerico =  [100, 0.001, 0, 0.5, 0.5];

posta = fminsearch(f, [1,1]);

resultadosAn = zeros(4,1);
resultadosNum = zeros(4,1);

resultadosAn(1) = norm(a1(f, [1,1], 1, opcAnalitico, gf) - posta);
resultadosAn(2) = norm(a1(f, [1,1], 2, opcAnalitico, gf) - posta);
resultadosAn(3) = norm(a1(f, [1,1], 3, opcAnalitico, gf) - posta);
resultadosAn(4) = norm(a1(f, [1,1], 4, opcAnalitico, gf) - posta);

resultadosNum(1) =norm( a1(f, [1,1], 1, opcNumerico, gf) - posta);
resultadosNum(2) =norm( a1(f, [1,1], 2, opcNumerico, gf) - posta);
resultadosNum(3) =norm( a1(f, [1,1], 3, opcNumerico, gf) - posta);
resultadosNum(4) =norm( a1(f, [1,1], 4, opcNumerico, gf) - posta);



resultadosAn
resultadosNum

%% Testeamos Gradiente Conjugado

f = @(x)3*x(2)^2+x(1)^2+2*x(1)*x(2)+x(1)+3*x(2)
gf = @(x)[2*x(1)+2*x(2)+1,6*x(2)+2*x(1)+3]
hf = @(x)[2,2;2,6]
opcAnalitico = [100, 0.001, 1, 0.5, 0.5];
opcNumerico =  [100, 0.001, 0, 0.5, 0.5];

% Con las derivadas calculadas de manera analítica:
res1 = a2(f, [1,1], opcAnalitico, gf, hf);
res2 = a2(f, [1,1], opcNumerico, f, f);



