function hes = Hessiano(f,x0)

%C�lculo del hessiano num�ricamente

h=1e-6;

hes=zeros(2);
for i=1:length(x0)
    for j=1:length(x0)
        hes(i,j)= doblederivada(f,x0,i,j);
    end
end