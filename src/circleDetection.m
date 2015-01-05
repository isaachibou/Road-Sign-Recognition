function [ signs ] = circleDetection( I0, sens )
    
        %-- Find circles
        [centers, radii] = imfindcircles(I0,[15 30],'ObjectPolarity','dark', 'Sensitivity', .98);
        %h = viscircles(centers,radii);

        %-- Extract the three strongests
        [a, ~] = size(centers);

        limit = 3;
        if a < limit 
           limit = a; 
        end        

        signs = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});

        indexCircle = 1;
        for i=1:limit
            %-- Crop Circles
            [infX, supX, infY, supY] = floorCoordinates(centers(i,:), radii(i), size(I0,1), size(I0,2));
            [centers2, ~] = imfindcircles(I0(infY:supY, infX:supX, :),[15 30],'ObjectPolarity','dark', 'Sensitivity', sens);

            if size(centers2,1)>0
                [color, isError] = getColor(I0(infY:supY, infX:supX, :));
                if ~isError
                    signs(indexCircle).image = I0(infY:supY, infX:supX, :);
                    signs(indexCircle).shape = 'circular';
                    signs(indexCircle).color1 = color;
                    indexCircle = indexCircle + 1;
                end
            else
               %if one is not a circle, next too because order on strongest
               return 
            end
        end
    end


%% Determines if main color is red or blue
function [color, isQuiche] = getColor(I)
    I = rgb2hsv(I);
    [~, indexMax] = max(imhist(I(:,:,1)));
    isQuiche = false;
    color = '';
    if indexMax < 10 || indexMax > 240
        color = 'red';
    elseif indexMax > 140 && indexMax < 160
        color = 'blue';
    else
        isQuiche = true;
    end
end

%% Cast coordinates to integer keeping all infos while taking care that 
%  coordinates doesn't exceed image dimensions
function [infX, supX, infY, supY] = floorCoordinates(center, radii, width, height)
    infX = center(1) - radii;
    infY = center(2) - radii;
    supX = center(1) + radii;
    supY = center(2) + radii;

    infY = floor(infY);
    supY = ceil(supY);
    infX = floor(infX);
    supX = ceil(supX);
    if infY<1
       infY=1; 
    end
    if supY>width
       supY=width; 
    end
    if infX<1
       infX=1;
    end
    if supX>height
       supX=height;
    end
    return;
end