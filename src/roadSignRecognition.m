function [roadsigns] = roadSignRecognition( filepath )
    %% ROAD SIGN RECOGNITION
    % Application aiming at recognizing road signs on french roads.

    %% Initialization
    % Image reading
    roadsignImage = imread(filepath);

    % Declaration of detected roadsign structure
    roadsigns = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});

    % Learning phase
    % -- Defines the number of zone dividing the image
    % -- width
    m = 6;
    % -- height
    n = 6;
    % -- Learning
    if ~exist('learningDensities.mat', 'file')
        learningDensities = learningPhase(m,n);
    else
        learningDensities = load('learningDensities.mat','-ascii');
    end

    %% Circular Pannels
    % Look for circular shapes 
    circles = circleDetection(roadsignImage);

    % If at least one is found, add it to the roadsign collection
    if(not(isempty(circles)) && strcmp(circles(1).shape, 'circular'))
        roadsigns = [roadsigns circles];
    end

    %% Squares
    % Look for squared shapes in blue regions
    squares = squareDetection(roadsignImage);

    % If at least one is found, add it to the roadsign collection
    if(not(isempty(squares)) && strcmp(squares(1).shape, 'square'))
        roadsigns = [roadsigns squares];
    end

    %% Triangles 
    % Look for triangular shapes in red regions
    triangles = triangleDetection(roadsignImage);

    % If at least one is found, add it to the roadsign collection
    if(not(isempty(triangles)) && strcmp(triangles(1).shape,'triangular'))
        roadsigns = [roadsigns triangles];
    end

    %% Color detection
    colorDetection(roadsigns);

    %% Roadsign identification knowing shape, main color and secondary color

    for i = 1:size(roadsigns, 2)   
        % Dimensions of regarded rectangle
        R = [1 1 size(roadsigns(i).image,2) size(roadsigns(i).image,1)];
        
        mask = imcomplement(im2bw(rgb2gray(roadsigns(i).image),graythresh(rgb2gray(roadsigns(i).image))));
        graySign=rgb2gray(roadsigns(i).image).*uint8(mask);
        
        % Equalize histogram
        graySign = histeq(graySign);
        
        figure 
        imshow(graySign)
        
        % background must be black --> TODO: must be improved
        
        
        
        % Compute density for each area of the picture
        densities = computeDensities(graySign, R, m, n);

        % Class identification according to densities comparison
        roadsigns(i).id = seekClass(densities, learningDensities);
    end

end