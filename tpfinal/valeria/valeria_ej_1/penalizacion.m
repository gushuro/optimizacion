function solu=penalizacion(x)
N=floor(length(x)/2);

P=0;

%Restricciones de desigualdad
for i=1:N
    if i<N
        for j=i+1:N
            %Restricci�n de que la norma entre dos puntos sea menor o igual
            %que 1
            
            g= x(i)^ 2 + x(j) ^2 - 2*x(i)*x(j)*cos(x(i+N)-x(j+N)) -1;
            P= P + max(0,g)^2;
        end
        %Los �ngulos deben estar en sentido creciente
        g= x(i+N)-x(i+1+N);
        P= P + max(0,g)^2;
    end
    %Los radios son mayores o iguales que cero
    g= -x(i);
    P= P + max(0,g)^2;
    %Los radios son menores o iguales que uno
    g= x(i)-1;
    P= P + max(0,g)^2;
    %Los �ngulos son mayores o iguales que cero
    g= -x(i+N);
    P= P + max(0,g)^2;
    %Los �ngulos son menores o iguales que pi
    g=x(i+N) - pi;
    P= P + max(0,g)^2;
end

%Restricciones de igualdad

%El �ltimo �ngulo es pi y el �ltimo radio es cero.

P=P + (1/2)*(x(N)^2 +(x(end)-pi)^2);

solu=P;