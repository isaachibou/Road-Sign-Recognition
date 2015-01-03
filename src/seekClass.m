function [ class ] = seekClass( densities, base)
%Blablabla
      
    nBzone = size(densities, 2);
    nBclass = size(base, 1);
    diff = zeros(nBclass, 1);
    
    for i = 1:nBclass
        sum = 0;
        currentValue = 0;
        for j = 1:nBzone
            if j == 1
                % Save current value
                previousValue = abs(densities(j) - base(i,j));
            else
                % Difference between previous value and current value
                sum = sum + abs(previousValue - (densities(j) - base(i,j)));
                % Save current value
                previousValue = abs(densities(j) - base(i,j));
            end
        end
        diff(i) = sum/nBzone;
    end
    
    index = min(diff)
    class = find(diff == index);
end

