%Tp final- minimizacionn sin restricciones

%Largest small polygon- modelo 1

%f con input n =#cant lados
clear all
close all
%Cantidad de lados
n=5;
%Mejor area obtenida
best_value=0;
%Mejor solucion
best_solution=zeros(2*n,1);
trials=0;
%Cantidad de iteraciones maxima
max_trials=100;
%Seleccion del metodo de minimizacion
metodo=2; %1: gradiente 2: BFGS 3:gradiente conjugados
%Limite maximo para la penalidad
pen_tol=0.1;



while trials<= max_trials
    trials=trials+1;
    %Punto inicial al azar
    Opt.x0(1:n,1)=ones(n,1);
    Opt.x0(n+1:2*n,1)=pi*rand(n,1).*ones(n,1);
    %EXACTAS%
    %Opt.x0= [1/sqrt(2),1,1/sqrt(2),0,0,pi/4,pi/2,pi]'; n=4
    % Opt.x0= [1/sqrt(2),1,1/sqrt(2),0,0,pi/4,pi/2,pi]'; %n=6
    %-------%
    
    %Parametros para los metodos de minimizacion
    Opt.iter =1000; %M�xima cantidad de iteraciones,
    Opt.tol=1e-8; %Tolerancia en la norma de los puntos dados por dos iteraciones consecutivas,
    Opt.epsilon =0.02;% Epsilon del m�todo de Goldstein
    Opt.dir ='grad'; %Forma de elegir la direcci�n de descenso ('grad' o 'rotacion').
    Opt.theta =0.5; %Valor de theta para la rotaci�n
    %Opt.a = Extremo izq del intervalo de trisecci�n
    %Opt.b = Extremo derecho del intervalo de trisecci�n
    %Opt.iterT = Cantidad de Iteraciones de trisecci�n
    Opt.tolgrad=1e-8; %M�nima norma del gradiente para seguir iterando;
    Opt.busquedalineal='fminsearch';% 'fminsearch' o 'trisec', o 'Goldstein'
    %constante de penalizacion inicial
    C=2;%10
    %funcion a minimizar (area + cte*penalizacion)
    f=@(x) LGP(x)+C*penalizacion(x);
    %Seleccion del metodo de minimizacion
    if metodo==1
        solucion=metodo_gradiente(f,Opt);
    elseif metodo==2
        solucion=BFGS(f,Opt);
    elseif metodo==3
        solucion=gradiente_conjugado(f,Opt);
    end
    %while penalizacion(solucion)>0
    for i=1:10 %10 
        Opt.x0=solucion;
        C=C*2;%10
        f=@(x) LGP(x)+C*penalizacion(x);
        if metodo==1            
            solucion=metodo_gradiente(f,Opt);
            pen=penalizacion(solucion);
        elseif metodo==2
            solucion=BFGS(f,Opt);
            pen=penalizacion(solucion);
         elseif metodo==3
             solucion=gradiente_conjugado(f,Opt);
             pen=penalizacion(solucion);
        end
    end
    disp(['Maximum area: ',num2str(-LGP(solucion)),' - trial: ',num2str(trials)])
    if -LGP(solucion)>best_value && pen< pen_tol
        disp('***New best value***')
        best_value=-LGP(solucion);
        best_solution=solucion;
        pen_solution=pen;
    end
end
r=best_solution(1:n);
angle=best_solution(n+1:end);

hold on
line([r(1:n).*cos(angle(1:n));r(1).*cos(angle(1))],[r(1:n).*sin(angle(1:n));r(1).*sin(angle(1))])
title(['Modelo 1, n=', num2str(n), ' ,Metodo del gradiente'])
text(-0.1,0.55,['Area: ',num2str(best_value)])
axis equal

