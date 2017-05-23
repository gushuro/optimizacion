metodogradiente(@f, 0,0)

x = -1:0.05:1;

[X,Y] = meshgrid(x,x);

Z = f(X,Y);

surf(X,Y, Z);
