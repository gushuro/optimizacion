% Image = imread('sign_language.jpg');
% Image = imread('pacman.jpeg'); 
%Image = imread('coins.png');
% Image = imread('milk.jpg'); % FEA
% Image = imread('lenna.jpg');
% Image = imread('images.png');
% Image = imread('wrenches.jpg');
% Image = imread('people.png');
Image = imread('mafalda.jpg');

% Images = ['sign_language.jpg', 'pacman.jpeg', 'coins.png', 'milk.jpg','lenna.jpg','images.png','wrenches.jpg','people.png'];
if(size(Image,3) > 1)
    I = rgb2gray(Image);
else
    I = Image;
end
f_objetivo = @(x) f_obj(I, x, 300);
min_threshold = fminbnd(f_objetivo, 0.01, 3)

% plot(fudges, thresholds);
bordesPlot(I, min_threshold);

            