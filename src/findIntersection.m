function [ pt ] = findIntersection( line,line2 )
%find the intersection point of the 2 lines
    syms x y
    
    %conversion line in polar coordinate system in 2D coordinate system and resolve equation
    [solx,soly] = solve(line.rho == x *cosd(line.theta)+y*sind(line.theta),line2.rho == x *cosd(line2.theta)+y*sind(line2.theta), x, y);
    
    pt=[solx soly];
end

