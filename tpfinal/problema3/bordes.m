function bordes = bordes(imagen_original, sensibilidad)
% imagen_original es la imagen original en Blanco y Negro
% sensibilidad es el factor por el cual multiplicar el threshold en la
% búsqueda de bordes.

    method = 'canny';
    I = imagen_original;
    
    [~, threshold] = edge(I, method);
    % Menos sensibilidad nos da más bordes
    bordes_matlab = edge(I, method, threshold * sensibilidad);
    
    % Dilatamos bordes para pegar los que quedaron desconectados.
    seVertical = strel('line', 3, 90);  % 90grados, línea tamaño 3
    seHorizontal = strel('line', 3, 0); % 0grados, línea tamaño 3
    bordes_dilatados = imdilate(bordes_matlab, [seVertical seHorizontal]);

    % Rellenamos los agujeros.
    objetos_reconocidos_llenos =  imfill(bordes_dilatados, 'holes');

    % Serruchamos los objetos en la imagen, dos veces (uno para revertir la
    % dilatación, otro para poder obtener sus bordes).
    seD = strel('diamond',1);
    objetos_reconocidos_final = imerode(objetos_reconocidos_llenos,seD);
    objetos_reconocidos_final = imerode(objetos_reconocidos_final,seD);

    borde_objetos = bwperim(objetos_reconocidos_final);

% Solo para ver visualmente el borde sobre la imagen original.
    if (graficar)
        imagen_gris = cat(3, I, I, I);
        bordeVerde = 0*cat(3, I, I, I);
        for i=1:size(borde_objetos,1)
            for j=1:size(borde_objetos,2)
                if borde_objetos(i,j)
                    bordeVerde(i,j,2)= 255;
                end
            end
        end
        imagen_con_bordes = imagen_gris + bordeVerde;

        figure;
        imshow(imagen_con_bordes);
        title('outlined original image');
    end
    bordes = borde_objetos;
end

