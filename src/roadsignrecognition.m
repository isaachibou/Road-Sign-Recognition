clear;
clc;

%% RoadSignRecognition
% Application written to recognize road signs on french roads.
% May be use for one picture, or a folder of picture.

roadsign = imread('../data/test-image.png');

panel = struct('image', roadsign, 'shape', '', 'color1', '', 'color2', '', 'id', '');

%% Circular Pannels

[Circle1, Circle2, Circle3] = circleDetection(roadsign);

panel(1).image = Circle1;
panel(2).image = Circle2;
panel(3).image = Circle3;

panel(1).shape = 'circular';
panel(2).shape = 'circular';
panel(3).shape = 'circular';

%% Triangles + Squares

%% Stuff