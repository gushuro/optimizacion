function df = DifFinitas(f,x0,i)

%C�lculo de las derivadas parciales num�ricamente
h=0.001;

ei=zeros(length(x0),1);
ei(i)=h;
X0=x0+ei;

df= (feval(f,X0)-feval(f,x0))/h;