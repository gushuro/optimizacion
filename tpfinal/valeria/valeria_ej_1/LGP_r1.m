function area= LGP_r1(x)
N=length(x);


%Función De Largest Small Polygon

area=0;

for i=1:N-1
    area= area + sin(x(i+1)-x(i));
end

area= area + sin(x(1)-x(N));
area=-area/8;

