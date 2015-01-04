function [ signImage ] = getMatchingSign( id, shape )
%GETMATCHINGSIGN Summary of this function goes here
%   Detailed explanation goes here

    I = imread(strcat('../data/bdd_', shape, '_color.png'));
    R = load(strcat('learningRectangles_', shape, '.mat'),'-ascii');
    signImage = I(R(id,2) : R(id,4),(R(id,1) : R(id,3)), :);
        
end

