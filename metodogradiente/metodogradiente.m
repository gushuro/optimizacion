function metodogradiente = metodogradiente(f, x0,y0)
    f = @(x,y) (x-y).^4 + 2*x.^2 + y.^2 - x + 2*y;
    N = 1000;
    x = zeros(N+1,1);
    y = zeros(N+1,1);
    x(1) = x0;
    y(1) = y0;

    for i = 1:N
        i
        g = gradiente(f, x(i), y(i));
        d = -g;
        if (norm(d) < 0.001)
            break;
        end
        T = fminsearch(@(t) f(x(i)+t*d(1),y(i)+t*d(2)), 0);
        %T = triseccion(0, 80000, f, [x(i), y(i)], d);
        x(i+1) = x(i)-T*g(1);
        y(i+1) = y(i)-T*g(2);
    end

    xsurf = -1:0.05:1;

    [X,Y] = meshgrid(xsurf,xsurf);

    Z = f(X,Y);

    surf(X,Y, Z);
    hold on;
    plot(x,y, 'r+:');
end