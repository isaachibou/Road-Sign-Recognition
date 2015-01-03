function [ class ] = seekClass( densities, base)
%Blablabla
      
    zoneNum = size(densities, 2);
    classNum = size(base, 1);
    diff = zeros(classNum, 1);
    
    for i = 1:classNum
        ratio = 0;
        currentValue = 0;
        for j = 1:zoneNum
            if j == 1
                % Save current value
                currentValue = abs(densities(j) - base(i,j));
            else
                % Difference between previous value and current value
                ratio = ratio + abs(currentValue - (densities(j) - base(i,j)));
                % Save current value
                currentValue = abs(densities(j) - base(i,j));
            end
        end
        diff(i) = ratio/classNum;
    end
    
    index = min(diff);
    class = find(diff == index);
end

