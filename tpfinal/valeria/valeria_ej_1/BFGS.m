function resultado=BFGS(f,Opt,varargin)
%Broyde-Fletcher-Goldfarb-Shanno algorithm
%M�todo de Newton aproximado


%Input:  f= funcion
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
%        Opt.busquedalineal='fminsearch', o 'fminunc', o 'fminbnd', o
%        'trisec', o 'Goldstein'
%        % Tambi�n se puede ingresar el gradiente y el hessiano de manera
%        exacta en los otros dos par�metros (en ese orden necesariamente)


%Inicializaci�n
x0=Opt.x0;
x=Opt.x0;
iter=1;
sequence=x0;

tic
% Direcci�n del gradiente inicial
if nargin>2 %Si hay input de derivadas
    d0=-feval(varargin{1},x0);
else %Caso contrario calcular num�ricamente
    d0=-derivada(f,x0);
end

% Hessiano inicial aproximado con la identidad
H=eye(length(x0));
H_1=inv(H); %inversa del Hessiano
p = H_1*d0; %La direcci�n inicial es el gradiente. Este paso es innecesario si la aproximaci�n inicial del Hessiano es la identidad

f_aux= @(t) feval(f,x0 + t*p);

%Selecci�n del algoritmo de b�squeda lineal
if strcmp(Opt.busquedalineal,'fminsearch')
    a=fminsearch(f_aux,0);
elseif strcmp(Opt.busquedalineal,'trisec')
    a=trisec(f_aux,Opt);
elseif strcmp(Opt.busquedalineal,'Goldstein')
    alpha=1;
    %Evaluac�n inicial de la condici�n
    condicion=(feval(f,x0 + alpha*p)- feval(f,x0))/(alpha*-p'*p);
    
    %Ciclo: mientras la condici�n no sea satisfactoria
    while condicion < Opt.epsilon  || condicion> (1-Opt.epsilon )
        alpha= 0.2*alpha;
        condicion=(feval(f,x0 + alpha*p)- feval(f,x0))/(alpha*-p'*p);
    end
    a=alpha;
else
    error('Error en la elecci�n del m�todo')
end
    
s=a*p;

x0=x0+s;

% Direcci�n del gradiente
if nargin>2 %Si hay input de derivadas
    d=-feval(varargin{1},x0);
else %Caso contrario calcular num�ricamente
    d=-derivada(f,x0);
end
y=(-d)-d0;

%Actualiza la inversa del Hessiano
H_1 = H_1 + ((y*y')/(y'*s)) - ((H_1*s*s'*H_1)/(s'*H_1*s));

%Ciclo: mientras no se supere el m�ximo de iteraciones y la diferencia de
%dos pasos sucesivos sea mayor a la tolerancia
while iter<=Opt.iter && norm(x0-x)>Opt.tol
    x=x0;
    d_1=d;
    p = H_1*d0;

    f_aux= @(t) feval(f,x0 + t*p);

    %Selecci�n del algoritmo de b�squeda lineal
    if strcmp(Opt.busquedalineal,'fminsearch')
        a=fminsearch(f_aux,0);
    elseif strcmp(Opt.busquedalineal,'fminunc')
        a=fminunc(f_aux,0);
    elseif strcmp(Opt.busquedalineal,'fminbnd')
        a=fminbnd(f_aux,0,1);
    elseif strcmp(Opt.busquedalineal,'trisec')
        a=trisec(f_aux,Opt);
    elseif strcmp(Opt.busquedalineal,'Goldstein')
        alpha=1;
        %Evaluaci�n inicial de la condici�n
        condicion=(feval(f,x0 + alpha*p)- feval(f,x0))/(alpha*-p'*p);
        
        %Ciclo: mientras la condici�n no sea satisfactoria
        while condicion < Opt.epsilon  || condicion> (1-Opt.epsilon )
            alpha= 0.2*alpha;
            condicion=(feval(f,x0+ alpha*p)- feval(f,x0))/(alpha*-p'*p);
        end
        a=alpha;
    else
        error('Error en la elecci�n del m�todo')
    end
    
    s=a*p;
    
    x0=x0+s;
    sequence=[sequence,x0];

    % Direcci�n del gradiente
    if nargin>2 %Si hay input de derivadas
        d=-feval(varargin{1},x0);
    else %Caso contrario calcular num�ricamente
        d=-derivada(f,x0);
    end
    y=(-d)-d_1;
    
    %Actualiza la inversa del Hessiano
    H_1 = H_1 + ((y*y')/(y'*s)) - ((H_1*s*s'*H_1)/(s'*H_1*s));
    
    iter=iter+1;
end
resultado=x0;
