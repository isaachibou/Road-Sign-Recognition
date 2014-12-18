function [ pt ] = findIntersection( line,line2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms x y
    
    [solx,soly] = solve(line.rho == x *cosd(line.theta)+y*sind(line.theta),line2.rho == x *cosd(line2.theta)+y*sind(line2.theta), x, y);
    
    pt=[solx soly];
end

