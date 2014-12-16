clear;
clc;

%% RoadSignRecognition
% Application written to recognize road signs on french roads.
% May be use for one picture, or a folder of picture.

roadsign = imread('../data/test-image.png');

%% Circular Pannels

[Circle1, Circle2, Circle3] = circleDetection(roadsign);

figure
imshow(Circle1);

figure
imshow(Circle2);

figure
imshow(Circle3);