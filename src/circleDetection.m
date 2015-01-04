function [ signs ] = circleDetection( I )
    
    %-- Find circles
    [centers, radii] = imfindcircles(I,[15 30],'ObjectPolarity','dark', 'Sensitivity', .98);
    %h = viscircles(centers,radii);

    %-- Extract the three strongests
    [a, ~] = size(centers);
        
    limit = 2;
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
        
        figure('name', 'circle')
        imshow(I(infY:supY, infX:supX, :))
        signs(i).image = I(infY:supY, infX:supX, :);
        signs(i).shape = 'circular';
    end
end