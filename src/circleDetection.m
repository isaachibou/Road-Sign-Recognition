function [ signs ] = circleDetection( I )
    
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
        infX = floor(centers(i,1) - radii(i));
        supX = ceil(centers(i,1) + radii(i));

        infY = floor(centers(i,2) - radii(i));
        supY = ceil(centers(i,2) + radii(i));
       
        [centers2, radii2] = imfindcircles(I(infY:supY, infX:supX, :),[15 30],'ObjectPolarity','dark', 'Sensitivity', .92);
         
        if size(centers2,1)>0
            signs(i).image = I(infY:supY, infX:supX, :);
            signs(i).shape = 'circular';
        else
           %if one is not a circle, next too because order on strongest
           return 
        end
    end
end