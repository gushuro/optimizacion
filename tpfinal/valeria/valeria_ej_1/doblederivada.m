function df = doblederivada(f,x0,i,j)

%C�lculo de las componentes del Hessiano
g= @(y) DifFinitas(f,y,i);
df= DifFinitas(g,x0,j);




