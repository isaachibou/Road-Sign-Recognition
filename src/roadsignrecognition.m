clear;

%% RoadSignRecognition
% Application written to recognize road signs on french roads.
% May be use for one picture, or a folder of picture.

roadsign = imread('../data/test-image.png');

%% Treatment of the picture
% Binarization of the picture
bin_sign = binarization(roadsign);
% Cutting the sign off the picture
cut_sign = cutting(roadsign, bin_sign);

%% First classification : work on the shape
% Detection of the shape, given the binarized picture
shape = shapedetection(cut_sign);
% Detection of the color, given the cut sign
color = colordetection(cut_sign);
% Classification of the panel
first_classification = signclassification(shape, color);

%% Second classification : work on the sign content
% Detection of the content
content = contentdetection(cut_sign);
% Classification of the content
second_classification = contentclassification(content);

%% Conclusion
% Compute the two classification together
% Display the found sign