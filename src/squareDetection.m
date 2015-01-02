function [ signs ] = squareDetection( I0 )

    %-- Parameters
    filledProportion = 0.8;
    
    %-- Find blue zones in I
    I = rgb2hsv(I0);    
    s = size(I);

    IB = uint8(zeros(s));
    for i=1:s(1)
        for j=1:s(2)
            if ((I(i,j,1)>120/255 && I(i,j,1)<=175/255 ) && I(i,j,2)>=127.5/255 && I(i,j,3)>=20/255 )
                IB(i,j,:)= 255;
            end
        end
    end

    %-- Apply filters to improve square detection
%   erodeFilter = [0 1 0; 1 1 1; 0 1 0];
%   closeFilter = strel('disk', 4);
%   IB = imerode(IB, erodeFilter);
%   IB = imclose(IB, closeFilter);
  
    BW = IB(:,:,1);
    BW = imfill(BW, 'holes');
    
    %-- Locate blue signs bounding boxes
    [label, num] = bwlabel(BW);
    st = regionprops(label, 'BoundingBox' ); 
    props = [st.BoundingBox];
    props = reshape(props, [4 num]);
    
    %-- Keep only assumed squared signs function of the density of white
    %-- pixel and create them accordgin to standard structure
    signs(1) = struct('image', '', 'shape', '', 'color1', '', 'color2', '', 'id', '');
    signsIndex = 1;
    
%     figure
%     imshow(BW);
%     hold on
    
    for i = 1:num
        %-- Check height/width proportion and size to eliminate noise
        if(props(3,i)<10 || props(4,i)<10)
        elseif (props(3,i)/props(4,i) > 1.5 || props(4,i)/props(3,i) > 1.5)
        else 
            %-- Check density t determine if the object is appr. squared
            [infX, supX, infY, supY] = floorCoordinates(props(:,i), size(BW,2), size(BW,2));
            
            %-- Draw detected signs
            %rectangle('Position', props(:,i), 'EdgeColor', 'c');
            pixelNum = 0;
            density = 0;
            for l = infY : supY
                for c = infX : supX
                    if BW(l, c) > 250
                        density = density + 1;
                    end
                    pixelNum = pixelNum + 1;
                end
            end
            if density/pixelNum > filledProportion         
                %-- Draw detected signs
                % rectangle('Position', props(:,i), 'EdgeColor', 'r');
                %-- Create new squared sign to be returned by the function
                signs(signsIndex).image = I0(infY:supY, infX:supX, :);
                figure('name', 'square')
                imshow(signs(signsIndex).image)
                signs(signsIndex).shape = 'square';
                signs(signsIndex).color1 = 'blue';
                signsIndex = signsIndex + 1;
            end
        end
    end
    
    
%% Cast coordinates to integer keeping all infos while taking care that 
%  coordinates doesn't exceed image dimensions
function [infX, supX, infY, supY] = floorCoordinates(props, height, width)
    infX = props(1);
    infY = props(2);
    supX = infX + props(3);
    supY = infY + props(4);

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
    