% I = imread('coins.png');
% I = imread('foto.jpg');
% I= imread('digits.jpeg');
I= imread('wrenches.jpg');
I = rgb2gray(I);
% imshow(I)
%%
BW1 = edge(I,'sobel');
BW2 = edge(I,'canny');
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter                                   Canny Filter');


%%
A = zeros(size(I));
tol=10;
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
        if centro == 255
            if izquierda + derecha + arriba + abajo + arribaizq + arribader + abajoizq + abajoder<=255
               A(i,j) = 0; 
            end
        end
    end
end
BW2 = edge(I,'canny');

figure;
imshowpair(A,BW2, 'montage');
% montage(A);
            