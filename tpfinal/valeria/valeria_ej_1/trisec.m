function x = trisec(f_aux,Opt)

%Este archivo sirve para encontrar el paso mediante el método de trisección
%Input: f_aux= función de una sola variable
%        Opt.a = Extremo izq del intervalo de trisección
%        Opt.b = Extremo derecho del intervalo de trisección
%        Opt.iterT = Cantidad de Iteraciones de trisección

%Output= x= Mínimo en el intervalo dado




%TrisecciÃ³n
    x1=(Opt.b-Opt.a)/3+Opt.a;
    x2=2*(Opt.b-Opt.a)/3+Opt.a;
for i=1:Opt.iterT
    if f_aux(x1)<f_aux(x2)
        Opt.b=x2;
    elseif f_aux(x1)>f_aux(x2)
        Opt.a=x1;
    else
        Opt.a=x1;
        Opt.b=x2;
    end
    x1=(Opt.b-Opt.a)/3+Opt.a;
    x2=2*(Opt.b-Opt.a)/3+Opt.a;
end
x=(x1+x2)/2;