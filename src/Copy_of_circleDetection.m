function [ signs ] = circleDetection( I, sens )
    
    %-- Find circles
    [centers, radii] = imfindcircles(I,[15 30],'ObjectPolarity','dark', 'Sensitivity', .98);
    %h = viscircles(centers,radii);

    %-- Extract the three strongests
    [a, ~] = size(centers);
        
    limit = 3;
    if a < limit 
       limit = a; 
    end        
    
    signs = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});
    
    for i=1:limit
        %-- Crop Circles
        [infX, supX, infY, supY] = floorCoordinates(centers(i,:), radii(i), size(I,1), size(I,2))
%         infX = floor(centers(i,1) - radii(i));
%         supX = ceil(centers(i,1) + radii(i));
% 
%         infY = floor(centers(i,2) - radii(i));
%         supY = ceil(centers(i,2) + radii(i));
%        
        [centers2, ~] = imfindcircles(I(infY:supY, infX:supX, :),[15 30],'ObjectPolarity','dark', 'Sensitivity', sens);
         
        if size(centers2,1)>0
            signs(i).image = I(infY:supY, infX:supX, :);
            signs(i).shape = 'circular';
        else
           %if one is not a circle, next too because order on strongest
           return 
        end
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