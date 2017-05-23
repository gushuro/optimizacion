function gradiente = gradiente(f,x,y)
    h = 0.001;
    dx = (f(x+h, y) - f(x,y))/h;
    dy = (f(x, y+h) - f(x,y))/h;
    gradiente = [dx,dy];
end