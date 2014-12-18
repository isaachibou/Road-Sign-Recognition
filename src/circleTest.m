close all
clc
I=imread('paris.jpg');
imshow(I);
[centers, radii, metric] = imfindcircles(I,[5 10], 'ObjectPolarity','dark', ...
          'Sensitivity',0.92);

viscircles(centers,radii);