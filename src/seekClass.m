function [ class ] = seekClass( densities, base, isCircle, color1)
%Blablabla
      
    nBzone = size(densities, 2);
    nBclass = size(base, 1);
    
    from = 1;
    to = nBclass;
    diff = zeros(nBclass, 1);
    diff(:, 1) = 1000;
    
    if isCircle
       if strcmp(color1,'red')
           to = 19;
       else
           from = 20;
       end
    end

    for i = from:to
        sum = 0;
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
    
    [~, class] = min(diff);
end

