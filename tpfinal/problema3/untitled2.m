I = imread('coins.png');
I = imread('foto.jpg');
I= imread('digits.jpeg');
% I= imread('wrenches.jpg');
% I = imread('morron.png');
I= imread('muscle2z-gray.png');
% I = rgb2gray(I);
imshow(I)
%%
BW1 = edge(I,'sobel');
BW2 = edge(I,'canny');
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter                                   Canny Filter');
%%
[BW, threshold] = edge(I, 'canny');
threshold
fudgeFactor = 1.5;
BWs = edge(I,'canny', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');
%%
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');
%%
A = zeros(size(I));
tol=20;
for i=2:size(A,1)-1
    for j=2:size(A,2)-1
        centro=I(i,j);
        izquierda = I(i,j-1);
        derecha = I(i,j+1);
        arriba = I(i-1, j);
        arribaizq = I(i-1,j-1);
        if abs(centro-izquierda) > tol
            A(i,j) = 255;
        elseif abs(centro-arriba) > tol
            A(i,j) = 255;
        elseif abs(centro-arribaizq) > tol
            A(i,j) = 255;
        end
    end
end
B=A;
difuminados=0;
for i=2:size(A,1)-1
    for j=2:size(A,2)-1
        centro=A(i,j);
        izquierda = A(i,j-1);
        derecha = A(i,j+1);
        arriba = A(i-1, j);
        abajo = A(i+1, j);
        arribaizq = A(i-1,j-1);
        abajoizq = A(i+1,j-1);
        arribader = A(i-1,j+1);
        abajoder = A(i+1,j+1);
        vecinos_blancos = (izquierda + derecha + arriba + abajo + arribaizq + arribader + abajoizq + abajoder)/255;
        if centro == 255
            if vecinos_blancos <= 0
                B(i,j) = 0; 
            end
        elseif vecinos_blancos >=2
            difuminados = difuminados + 1;
%             B(i,j) = 255;
        end
    end
end
difuminados_2 = 0;
% C=B;
% for i=2:size(C,1)-1
%     for j=2:size(C,2)-1
%         centro=C(i,j);
%         izquierda = C(i,j-1);
%         derecha = C(i,j+1);
%         arriba = C(i-1, j);
%         abajo = C(i+1, j);
%         arribaizq = C(i-1,j-1);
%         abajoizq = C(i+1,j-1);
%         arribader = C(i-1,j+1);
%         abajoder = C(i+1,j+1);
%         vecinos_blancos = (izquierda + derecha + arriba + abajo + arribaizq + arribader + abajoizq + abajoder)/255;
%         if centro == 255
%             if vecinos_blancos == 0
%                 B(i,j) = 0; 
%             end
%         elseif vecinos_blancos >=2
%             difuminados_2 = difuminados_2 + 1;
%             B(i,j) = 255;
%         end
%     end
% end
difuminados
difuminados_2
BW2 = edge(B,'sobel');

figure;
imshow(B);
% imshowpair(B, BW2, 'montage');
% montage(A);
            