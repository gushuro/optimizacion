function [x,fx] = a4(f, xmin, xmax, N, T, plotear)  
    %RECOCIDO SIMULADO v2.0
    n = size(xmin,2);   
    bestx = rand(1,n).*(xmax-xmin) + xmin;       % Tomamos x0 aleatorio.
    best = f(bestx);
    actualx = bestx;
    actual = best;
    Tinicial = T;
    initialSigma = (xmax-xmin)/3;
    
    stepsWithoutImprovement = 0;        %Guardamos cantidad de iteraciones sin mejora global
    iterationsSinceReset = 0;            %Guardamos cantidad de iteraciones desde el último reset.
    
    recorridos = zeros(2,N+1);
    y = 1:(N+1);    
    
    %ploteamos función
    if plotear == 2
        xsurf = linspace(xmin(1), xmax(1), 100);
        ysurf = linspace(xmin(2), xmax(2), 100);
    
        [X,Y] = meshgrid(xsurf,xsurf);
        Z = X;
        for i = 1:size(X,1)
            size(X,1)-i
            for j = 1:size(X,2)
                Z(i,j) = f([X(i,j),Y(i,j)]);
            end
        end
        surf(X,Y,Z);
        hold on;    
    end

    
    
    for i = 1:N
        %actualx    %% Descomentar para ir viendo la evolución de x.
        %pause(0.001)
        
    % A medida que avanzamos, además de reducir la temperatura disminuimos
    % El entorno donde buscamos el próximo x.
        a = actualx + randn(1,n).*initialSigma/(iterationsSinceReset+10);
        a = min(a, xmax);   %Bound checks
        a = max(a, xmin);   %Bound checks
        
        if f(a) < actual    %Si el nuevo punto es mejor, me muevo
            actualx = a;
            actual = f(a);
        else            % si el nuevo punto es peor que el que teniamos, aceptarlo con una probabilidad sugerida p 
            p = exp((actual - f(a))/T); 
            if rand < p % la proba de que rand sea menor a p es justamente p
                actualx = a;
                actual = f(a);
            end
        end
        
        
        % Para graficar ------
        y(i) = actual;      
        if plotear == 2
            recorridos(:,i) = actualx;
            plot3(recorridos(1,i), recorridos(2,i), y(i), 'r+:');
        end
        % Para graficar ------
        
        
        
        % Además, si el nuevo punto es globalmente el mejor encontrado,
        % realizamos un pequeño método de descenso desde ese punto
        if actual < best && iterationsSinceReset > 100 
            % log(N) iteraciones de método del gradiente.
            %actualx = metodoGradiente(f, actualx, 2, [log(N), 0.001, 0], f, xmin, xmax);
            actual = f(actualx);
            bestx = actualx;
            best = actual;
            stepsWithoutImprovement = 0;
        else
            stepsWithoutImprovement = stepsWithoutImprovement + 1;
        end
        %T=T*0.99;
        
        %Cada 10 iteraciones, disminuimos un poco la temperatura.
        if mod(i,10)
            T = T*0.985;
        end
        
        % Si por acá no estamos viendo mejoras, reiniciamos. Esto, a lo 
        % sumo 20 veces.
        if stepsWithoutImprovement > N/20
            actualx = rand(1,n).*(xmax-xmin) + xmin;
            actual = f(actualx);
            iterationsSinceReset = 0;
            stepsWithoutImprovement = 0;
            T = Tinicial;
        else
            iterationsSinceReset = iterationsSinceReset + 1;
        end
    end
    %bestx
    %best
    
    % Podríamos terminar acá. Pero, en vez de quedarnos con el mejor punto
    % encontrado, buscamos un mínimo local cercano a él. 
    [x,fx] = metodoGradiente(f, bestx, 2, [N/10, 0.001, 0], f, xmin, xmax);
    y(N+1) = fx;
    if plotear == 1
        plot(1:(N+1), y)
        set(gca, 'YScale', 'log')
    end
    if plotear == 2
        plot3(x(1), x(2), fx, 'g.:','MarkerSize', 30);
    end
    
    
%    
%     for i = 1:(N+1)
%         plot3(recorridos(1,i), recorridos(2,i), y(i), 'r+:');
%     end
end
