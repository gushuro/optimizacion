function area= LGP(x)

N=floor(length(x)/2);

%Función De Largest Small Polygon

area=0;

for i=1:N-1
    area= area + x(i+1)*x(i)*sin(x(i+1+N)-x(i+N));
end

area=-area/2;

