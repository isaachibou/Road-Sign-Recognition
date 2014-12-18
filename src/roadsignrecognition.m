close all;
clear;
clc;

%% RoadSignRecognition
% Application written to recognize road signs on french roads.
% May be use for one picture, or a folder of picture.

roadsignImage = imread('crossing_010.png');

% Declaration of structure
roadsigns = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});

%% Circular Pannels
circles = circleDetection(roadsignImage);
if strcmp(circles(1).shape,'circular')
    roadsigns = [roadsigns circles];
end

%% Squares
squares = squareDetection(roadsignImage);
if(strcmp(squares(1).shape, 'square'))
    roadsigns = [roadsigns squares];
end

%% Triangles 
triangles = triangleDetection(roadsignImage);
if strcmp(triangles(1).shape,'triangular')
    roadsigns = [roadsigns triangles];
end

%% Show all detected signs
for i = 1:size(roadsigns,2)
    figure('name', 'final')
    imshow(roadsigns(i).image)
end

%% Color detection
%index exceeds matrix dimension
%colordetection(panels);
