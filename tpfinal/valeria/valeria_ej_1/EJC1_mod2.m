%Tp final- minimización sin restricciones

%Largest small polygon - Modelo 2

clear all
close all
%Cantidad de lados
n=32;
%Mejor area obtenida
best_value=0;
%Mejor solucion
best_solution=zeros(n,1);
%Vertices de la mejor solucion
best_points=zeros(n,2);

trial=0;
%Cantidad de iteraciones maxima
max_trials=10;
%Limite maximo para la penalidad
pen_tol=0.1;
%Seleccion del metodo de minimizacion
metodo=2; %1: gradiente 2: BFGS 3: gradiente_conjugado



while trial<max_trials 
    K=0; %Término para ver dónde se realiza el diámetro
    L=0;%Término para ver dónde se realiza el diámetro
    r=(1/2);

    trial=trial+1;
    %Punto inicial al azar
    Opt.x0(1:n,1)=2*pi*rand(n,1);
    
    % POLÍGONO REGULAR
    %Opt.x0(1:n,1)=2*pi/n:2*pi/n:2*pi;
    %-------%
    %Parametros para los metodos de minimizacion
    
    Opt.iter=1000; %Máxima cantidad de iteraciones,
    Opt.tol=1e-8; %Tolerancia en la norma de los puntos dados por dos iteraciones consecutivas,
    Opt.epsilon =0.02;% Epsilon del método de Goldstein
    Opt.dir ='grad'; %Forma de elegir la dirección de descenso ('grad' o 'rotacion').
    Opt.theta =0.5; %Valor de theta para la rotación
    Opt.a =0; %Extremo izq del intervalo de trisección
    Opt.b =1;% Extremo derecho del intervalo de trisección
    Opt.iterT =100; %Cantidad de Iteraciones de trisección
    Opt.tolgrad=1e-8; %Mínima norma del gradiente para seguir iterando;
    Opt.busquedalineal='fminsearch';%  'fminsearch'  o 'trisec', o 'Goldstein'
    %constante de penalizacion inicial
    C=2;
    %funcion a minimizar (area + cte*penalizacion)
    f=@(x) LGP_r1(x)+C*penalizacion_r1(x);
    
    %Seleccion del metodo de minimizacion
    if metodo==1
        solucion=metodo_gradiente(f,Opt);
    elseif metodo==2
       solucion=BFGS(f,Opt);
    elseif metodo==3
       solucion=gradiente_conjugado(f,Opt);
    end
    %while penalizacion(solucion)>0- Método de penalización
    for i=1:10
        C=C*2;
        f=@(x) LGP_r1(x)+C*penalizacion_r1(x);
        if metodo==1
            solucion=metodo_gradiente(f,Opt);
            pen=penalizacion_r1(solucion);
            
        elseif metodo==2
            solucion=BFGS(f,Opt);
            pen=penalizacion_r1(solucion);
        elseif metodo==3
            solucion=gradiente_conjugado(f,Opt);
            pen=penalizacion_r1(solucion);
        end
        Opt.x0=solucion;
    end
    
    %Busco el diámetro del polígono
    points = r.*[cos(solucion),sin(solucion)];
    diametro=0;
    for k=1:n-1
        for l=(k+1):n
            long=norm(points(k,1:2)-points(l,1:2));
            if long>diametro
                diametro=long;
            end
        end
    end
    
    %Si el diámetro es distinto de 1, reescalo
    reescalamiento= 1/diametro;
    r=reescalamiento*r;
    
    %Update diameter
    points =r.*[cos(solucion),sin(solucion)];
    diametro=0;
    for k=1:n-1
        for l=(k+1):n
            long=norm(points(k,1:2)-points(l,1:2));
            if long>diametro
                diametro=long;
                K=k;
                L=l;
            end
        end
    end
    
    %solucion = r.*solucion;
    
    disp(['Maximum area: ',num2str(-(reescalamiento^2)*LGP_r1(solucion)),' - penalty: ',num2str(pen),' - Reescaling: ', num2str(reescalamiento),' - trial: ',num2str(trial)])
    
    if -(reescalamiento^2)*LGP_r1(solucion)>best_value && pen< pen_tol
        
        disp('***New best value***')
        best_value=-(reescalamiento^2)*LGP_r1(solucion);
        best_solution=solucion;
        best_trial=trial;
        best_points=points;
        best_K=K;
        best_L=L;
        best_diam=diametro;
        best_reesc=reescalamiento;
        best_pen=pen;
    end
   
end

% GRAPHICAL OUTPUT
figure
hold on

line([best_points(:,1);best_points(1,1)],[best_points(:,2);best_points(1,2)])
plot(best_points(:,1),best_points(:,2),'*')

t = linspace(0,2*pi);
plot((diametro/2)*cos(t),(diametro/2)*sin(t),'r')

line([best_points(best_K,1);best_points(best_L,1)],[best_points(best_K,2);best_points(best_L,2)])
%line([best_points(best_K,1)],[best_points(best_K,2)])
text((best_points(best_K,1)+best_points(best_L,1))/2,(best_points(best_K,2)+best_points(best_L,2))/2,['Reescalamiento: ',num2str(best_reesc)])

text(0,-0.45,['Area: ',num2str(best_value)])
title(['Modelo 2, n=', num2str(n), ' ,BFGS'])
axis equal