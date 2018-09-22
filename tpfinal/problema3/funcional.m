function funcional = funcional(imagen_original, bordes_imagen, nu)
% Calcula una medida sobre una imagen, relacionando tamaño de borde y
% suavidad. Cuánto más bajo dé, mejor habrá sido la elección de los pixeles
% marcados como borde
% Parámetros:
%
% imagen_original es la imagen original en Blanco y Negro
% bordes_imagen es una matriz de valores lógicos que indica dónde hay borde
% nu indica el peso que se le da a la medida del borde en el funcional.

    tamanio_borde = sum(sum(bordes_imagen))
    integral_gradiente = 0;
    for i = 2:size(imagen_original,1)-1
        for j = 2:size(imagen_original,2)-1
            centro=bordes_imagen(i,j);
            izquierda = bordes_imagen(i,j-1);
            derecha = bordes_imagen(i,j+1);
            arriba = bordes_imagen(i-1, j);
            abajo = bordes_imagen(i+1, j);
            arribaizq = bordes_imagen(i-1,j-1);
            abajoizq = bordes_imagen(i+1,j-1);
            arribader = bordes_imagen(i-1,j+1);
            abajoder = bordes_imagen(i+1,j+1);
            vecinos_borde = (centro + izquierda + derecha + arriba + abajo)/255;
            if (vecinos_borde == 0)
                dx = double(abs(imagen_original(i,j)-imagen_original(i,j-1)) + abs(imagen_original(i,j)-imagen_original(i,j+1)))/2;
                dy = double(abs(imagen_original(i,j)-imagen_original(i-1,j)) + abs(imagen_original(i,j)-imagen_original(i+1,j)))/2;
                integral_gradiente = integral_gradiente + dx^2 + dy^2;
            end
        end
    end
    funcional = integral_gradiente + nu*tamanio_borde;
end

