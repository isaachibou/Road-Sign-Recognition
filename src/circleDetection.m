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
    
    signs(1) = struct('image', '', 'shape', '', 'color1', '', 'color2', '', 'id', '');
    signsIndex = 1;
    
    for i=1:limit
        %-- Crop Circles
        infX = floor(centers(i,1) - radii(i));
        supX = ceil(centers(i,1) + radii(i));

        infY = floor(centers(i,2) - radii(i));
        supY = ceil(centers(i,2) + radii(i));
        
        %figure('name', 'circle')
        %imshow(I(infY:supY, infX:supX, :))
        signs(signsIndex).image = I(infY:supY, infX:supX, :);
        signs(signsIndex).shape = 'circular';
        signsIndex = signsIndex + 1;
    end
end