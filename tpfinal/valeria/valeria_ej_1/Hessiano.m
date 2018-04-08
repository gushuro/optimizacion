function hes = Hessiano(f,x0)

%Cálculo del hessiano numéricamente

h=1e-6;

hes=zeros(2);
for i=1:length(x0)
    for j=1:length(x0)
        hes(i,j)= doblederivada(f,x0,i,j);
    end
end