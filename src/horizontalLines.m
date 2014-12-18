function [ horizontal ] = horizontalLines( lines )
%   return list of horizontal lines from lines

    %parameters
    angleError=5;
    
    c=size(lines,2);
    horizontal(1,1)=struct('point1',[],'point2',[],'theta',0,'rho',0);
    i=1;
    for k=1:c
       if abs(lines(k).theta) >=90-angleError && abs(lines(k).theta<=90+angleError)
            horizontal(1,i)= lines(k);
            i=i+1;
       end
    end
       
end

