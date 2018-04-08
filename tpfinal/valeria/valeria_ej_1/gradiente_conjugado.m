function resultado=gradiente_conjugado(f,Opt,varargin)


%Input:  f = función
%        Opt.x0= Punto inicial
%        Opt.iter = Máxima cantidad de iteraciones,
%        Opt.tol = Tolerancia en la norma de los puntos dados por dos iteraciones consecutivas,
%        Opt.tolgrad = Mínima norma del gradiente para seguir iterando
%        También se puede ingresar el gradiente y el hessiano de manera
%        exacta en los otros dos parámetros (en ese orden
%        necesariamente)


%Output: results.minimo=Mínimo del problema;
%        results.Niter=Cantidad de iteraciones realizadas
%        results.sequence= Sucesión de Xk's generada
%        results.time= Tiempo que tarda en hallar el mínimo;



%Inicialización
x0=Opt.x0;
for l=1:length(x0)
    x(l,1)=Inf;
end
iter=1;
sequence=x0;

tic
%Ciclo: mientras no se supere el máximo de iteraciones y la diferencia de
%dos pasos sucesivos sea mayor a la tolerancia
while iter<=Opt.iter && norm(x0-x)>Opt.tol
    x=x0;

    % Dirección del gradiente
    if length(varargin)>0 %Si hay input de derivadas
        d=-feval(varargin{1},x0);
    else %Caso contrario calcular numéricamente
        d=-derivada(f,x0);
    end

    if norm(d)<Opt.tolgrad
        break %El gradiente es prácticamente nulo -> mínimo local
    end
    
    g=-d;
    for i=0:length(x0)-1
        % Hessiano
        if length(varargin)>1 %Si hay input del hessiano
            H=feval(varargin{2},x0); 
        else %Caso contrario calcular numéricamente
            H=Hessiano(f,x0);
        end
        
        if  d'*H*d>0
            alpha=(-g'*d)/(d'*H*d);
            x0= x0 + alpha*d; %Actualizar valor de la solución
            sequence=[sequence,x0];
            
            if length(varargin)>0 %Si hay input de derivadas
                d=-feval(varargin{1},x0);
            else %Caso contrario calcular numéricamente
                d=-derivada(f,x0);
            end
            g=-d;
            beta=(g'*H*d)/(d'*H*d);
            d=-g + beta*d;
        else
            break
        end
    end
iter=iter+1;    
end
resultado=x0;
