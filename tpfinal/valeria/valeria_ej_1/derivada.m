function [grad]=derivada(f,x0)

%Cálculo del gradiente

h=1e-5;

grad=zeros(length(x0),1);
for i=1:length(x0)
    ei=zeros(length(x0),1);
    ei(i)=h;
    X0=x0+ei;
    grad(i,1)=(feval(f,X0)-feval(f,x0))/h;
end