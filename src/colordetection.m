function [ panels ] = colordetection( panels )
% COLORDETECTION
% Detect the two main color of the panel, and update it in the panel data,
% so it can be used later to simplify the decision process.

    % Iterating the process in each panel
    for i=1:1:size(panels, 2)
        I = panels(i).image;

        % Searching colors using histograms, so maximum occurence of a
        % color can be counted.
        red     = imhist(I(:,:,1));
        green   = imhist(I(:,:,2));
        blue    = imhist(I(:,:,3));
        
        % For the first color, we don't considere black as an option, so we
        % don't search the max in this range.
        [~, ired]   = max(red(2:256));
        [~, igreen] = max(green(2:256));
        [~, iblue]  = max(blue(2:256));

        % Searching the first color (usually the main) and partially
        % removing it from the histogram.
        if (ired <= 127) && (igreen <= 127) && (iblue >= 127)
            blue(127:256) = blue(127:256)/2;
            panels(i).color1 = 'blue';
        elseif (ired >= 127) && (igreen <= 127) && (iblue <= 127)
            red(127:256) = red(127:256)/2;
            panels(i).color1 = 'red';
        elseif (ired >= 127) && (igreen >= 127) && (iblue >= 127)
            red(127:256)   = red(127:256)/2;
            green(127:256) = green(127:256)/2;
            blue(127:256)  = blue(127:256)/2;
            panels(i).color1 = 'white';
        elseif (ired <= 127) && (igreen <= 127) && (iblue <= 127)
            red(1:127)   = red(1:127)/2;
            green(1:127) = green(1:127)/2;
            blue(1:127)  = blue(1:127)/2;
            panels(i).color1 = 'black';
        else
            disp('No valid color found');
        end
        
        % Searching a second main color.
        [~, ired]   = max(red);
        [~, igreen] = max(green);
        [~, iblue]  = max(blue);
        
        if (ired <= 127) && (igreen <= 127) && (iblue >= 127)
            panels(i).color2 = 'blue';
        elseif (ired >= 127) && (igreen <= 127) && (iblue <= 127)
            panels(i).color2 = 'red';
        elseif (ired >= 127) && (igreen >= 127) && (iblue >= 127)
            panels(i).color2 = 'white';
        elseif (ired <= 127) && (igreen <= 127) && (iblue <= 127)
            panels(i).color2 = 'black';
        else
            disp('No valid color found');
        end
    end
end