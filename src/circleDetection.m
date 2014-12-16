function [ A,B,C ] = circleDetection( I )
    
    %-- Find circles
    [centers, radii] = imfindcircles(I,[15 30],'ObjectPolarity','dark', 'Sensitivity', .98);
    h = viscircles(centers,radii);

    %-- Extract the three strongests
    [a, b] = size(centers);
        
    limit = 3;
    if a < limit 
       limit = a; 
    end        
    
    for i=1:limit
        %-- Crop Circles
        infX = floor(centers(i,1) - radii(i));
        supX = ceil(centers(i,1) + radii(i));

        infY = floor(centers(i,2) - radii(i));
        supY = ceil(centers(i,2) + radii(i));
        
        if i == 1
            A = I(infY:supY, infX:supX, 1:3);
        elseif i == 2
            B = I(infY:supY, infX:supX, 1:3);
        elseif i == 3
            C = I(infY:supY, infX:supX, 1:3);
        end
    end
end

