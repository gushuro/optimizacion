function  results=metodo_gradiente(f,Opt,varargin)
%Input:  f= funcion, 

%        Opt.x0= Punto inicial
%        Opt.iter = M�xima cantidad de iteraciones,
%        Opt.tol = Tolerancia en la norma de los puntos dados por dos iteraciones consecutivas, 
%        Opt.epsilon = Epsilon del m�todo de Goldstein
%        Opt.dir = Forma de elegir la direcci�n de descenso ('grad' o 'rotacion').
%        Opt.theta = Valor de theta para la rotaci�n
%        Opt.a = Extremo izq del intervalo de trisecci�n
%        Opt.b = Extremo derecho del intervalo de trisecci�n
%        Opt.iterT = Cantidad de Iteraciones de trisecci�n
%        Opt.tolgrad = M�nima norma del gradiente para seguir iterando
%        Opt.busquedalineal='fminsearch', o 'fminunc', o 'fminbnd', o 'trisec', o 'Goldstein'

%        % Tambi�n se puede ingresar el gradiente y el hessiano de manera
%        exacta en los otros dos par�metros (en ese orden necesariamente)


%Output: results.minimo=M�nimo del problema;
%        results.Niter=Cantidad de iteraciones realizadas
%        results.sequence= Sucesi�n de Xk's generada
%        results.time= Tiempo que tarda en hallar el m�nimo;



%Inicializaci�n
x0=Opt.x0;
for l=1:length(x0)
    x(l,1)=Inf;
end
iter=1;
sequence=x0;

tic
%Ciclo: mientras no se supere el m�ximo de iteraciones y la diferencia de
%dos pasos sucesivos sea mayor a la tolerancia

while iter<=Opt.iter && norm(x-x0)>Opt.tol 
    x=x0;
    
    
    % Direcci�n del gradiente
    if length(varargin)>0 %Si hay input de derivadas
        d=-feval(varargin{1},x0);
    else %Caso contrario calcular num�ricamente
        d=-derivada(f,x0);
        
    end
    
    if norm(d)<Opt.tolgrad
        break %El gradiente es practicamente nulo -> m�nimo local
    end
    
    
    % Funci�n auxiliar unidimensional en la direcci�n "d"
    
    f_aux= @(t) feval(f,x0 + t*d);
    
    %Selecci�n del algoritmo de b�squeda lineal
    if strcmp(Opt.busquedalineal,'fminsearch') && strcmp(Opt.dir,'grad')
        [minimo,a,motivo_parada]=fminsearch(f_aux,0);
        %motivo_parada
     elseif strcmp(Opt.busquedalineal,'trisec')
        minimo=trisec(f_aux,Opt);
    elseif strcmp(Opt.busquedalineal,'Goldstein') && strcmp(Opt.dir,'grad')     
        alpha=1;
        %Evaluaci�n inicial de la condici�n de Goldstein
        condicion=(feval(f,x0+ alpha*d)- feval(f,x0))/(alpha*-d'*d);
        
        %Ciclo: mientras la condici�n no sea satisfactoria vamos achicando
        %alpha
        while condicion < Opt.epsilon  || condicion > (1-Opt.epsilon )
            alpha= 0.2*alpha;
            condicion=(feval(f,x0+ alpha*d)- feval(f,x0))/(alpha*-d'*d);
        end
        
        minimo=alpha;
    else
        error('Error en la elecci�n del m�todo')
    end
   
    x0=x0+minimo*d; %Actualizaci�n de la variable
    sequence=[sequence,x0]; %Vamos guardando los resultados de cada iteraci�n
    iter=iter+1;
    
end
results=x0;
