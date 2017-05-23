%% Funciones de ejemplo


f = @(x)(x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);
gf = @(x)[4*(x(1)-x(2)).^3+4*x(1)-1,(-4)*(x(1)-x(2)).^3+2*x(2)+2];

%Opciones para probar. Usa gradiente analítico/numérico
opcAnalitico = [100, 0.001, 0.001, 1, 0.5, 0, 0.5];
opcNumerico = [100, 0.001, 0.001, 0, 0.5, 0, 0.5];

resultadosAn = zeros(4,2);
resultadosAn(1,:) = a1(f, [1,1], 1, opcAnalitico, gf);
resultadosAn(2,:) = a1(f, [1,1], 2, opcAnalitico, gf);
resultadosAn(3,:) = a1(f, [1,1], 3, opcAnalitico, gf);
resultadosAn(4,:) = a1(f, [1,1], 4, opcAnalitico, gf);

resultadosNum = zeros(4,2);
resultadosNum(1,:) = a1(f, [1,1], 1, opcNumerico, gf);
resultadosNum(2,:) = a1(f, [1,1], 2, opcNumerico, gf);
resultadosNum(3,:) = a1(f, [1,1], 3, opcNumerico, gf);
resultadosNum(4,:) = a1(f, [1,1], 4, opcNumerico, gf);