function bordes = bordes(imagen_original, fudge_factor)
% Calcula una medida sobre una imagen, relacionando tamaño de borde y
% suavidad. Cuánto más bajo dé, mejor habrá sido la elección de los pixeles
% marcados como borde
% Parámetros:
%
% imagen_original es la imagen original en Blanco y Negro
% fudge_factor es el factor por el cual multiplicar el threshold en la
% búsqueda de bordes.
    method = 'canny';
    graficar = false;
    I = imagen_original;
    
    [~, threshold] = edge(I, method);
    % Menos fudgeFactor nos da más bordes
    BWs = edge(I, method, threshold * fudge_factor);
%     figure, imshow(BWs), title('binary gradient mask');
    
    % Dilatamos bordes para pegar los que quedaron desconectados.
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BWsdil = imdilate(BWs, [se90 se0]);
%     figure, imshow(BWsdil), title('dilated gradient mask');

    % Rellenamos los agujeros.
    BWdfill =  imfill(BWsdil, 'holes');
%     figure, imshow(BWdfill);
%     title('binary image with filled holes');

    % Serruchamos los objetos en la imagen, dos veces.
    seD = strel('diamond',1);
    BWfinal = imerode(BWdfill,seD);
    BWfinal = imerode(BWfinal,seD);
%     figure, imshow(BWfinal), title('segmented image');

    BWoutline = bwperim(BWfinal);
    
%     funcional(I, BWoutline, 10)
% Solo para ver visualmente el borde sobre la imagen original.
    if (graficar)
        Segout = cat(3, I, I, I);
        bordeVerde = 0*cat(3, I, I, I);
        for i=1:size(BWoutline,1)
            for j=1:size(BWoutline,2)
                if BWoutline(i,j)
                    bordeVerde(i,j,2)= 255;
                end
            end
        end
%         size(Segout)
%         size(bordeVerde)
        Segout = Segout + bordeVerde;

        figure;
        size(Segout)
        imshow(Segout);
        title('outlined original image');
    end
    bordes = BWoutline;
end

