%Calcula el área de un polígono regular con diámetro 1 (solo funciona para cantidad impar de lados)
function [solucion]=area_poligono_regular(n)



if mod(n,2)==0
    disp('Ingresar n impar')
else
    
    %Amplitud del ángulo del polígono
    
    angulo = pi*(n-2)/n;
    
    beta = angulo- (1/2)*(pi*(floor(n/2) -1) -angulo *(floor(n/2)-1));
    
    opuesto=sin(beta);
    
    semi_lado=sqrt(1- opuesto^2);
    
    perimetro=2*n*semi_lado;
    
    x=(semi_lado^2+ opuesto^2)/(2*opuesto);
    
    apotema= opuesto - x;
    
    solucion=perimetro*apotema/2;
end



