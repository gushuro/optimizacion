function solu=penalizacion_r1(x)
P=0;
N=length(x);

%Restricciones de desigualdad
for i=1:N
    if i<N
        %Los ángulos tienen que estar en orden creciente
        g= x(i)-x(i+1);
        P= P + max(0,g)^2;
    end
   
    %Los ángulos deben ser mayores que cero
    g= -x(i);
    P= P + max(0,g)^2;
    %Los ángulos deben ser menores que 2*pi
    g=x(i) - 2*pi;
    P= P + max(0,g)^2;
end

%Restricciones de igualdad

%El último angulo es exactamente 2*pi
P=P + (x(length(x))-2*pi)^2;

solu=P;