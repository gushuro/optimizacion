Image = imread('mafalda.jpg');
% Image = imread('sign_language.jpg');
% Image = imread('coins.png');
% Image = imread('monedas.jpeg');
% Image = imread('lenna.jpg');
% Image = imread('images.png');
% Image = imread('wrenches.jpg');
% Image = imread('people.png');
% Image = imread('pacman.jpeg'); 
% Image = imread('florero2.jpg'); 
% Image = imread('bottles.png'); 
% Image = imread('ketchup2.jpg'); 
if(size(Image,3) > 1)
    I = rgb2gray(Image);
else
    I = Image;
end
% imshow(I);
f_objetivo = @(x) f_obj(I, x, 300);
min_sensibilidad = fminbnd(f_objetivo, 0.01, 3)

bordesPlot(I, min_sensibilidad);
