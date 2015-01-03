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
    learningDensities = learningPhase(m,n);


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

        % Compute densities by zoning
        densities = computeDensities(roadsigns(i).image, R, m, n);
        % base = load('Densities.mat','-ascii');

        % Class identification according to densities comparison
        roadsigns(i).id = seekClass(densities, learningDensities);
    end


    %% Show every detected signs
    % for i = 1:size(roadsigns,2)
    %     figure('name', 'final')
    %     imshow(roadsigns(i).image)
    % end
end