function x = trisec(f_aux,Opt)

%Este archivo sirve para encontrar el paso mediante el m�todo de trisecci�n
%Input: f_aux= funci�n de una sola variable
%        Opt.a = Extremo izq del intervalo de trisecci�n
%        Opt.b = Extremo derecho del intervalo de trisecci�n
%        Opt.iterT = Cantidad de Iteraciones de trisecci�n

%Output= x= M�nimo en el intervalo dado




%Trisección
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