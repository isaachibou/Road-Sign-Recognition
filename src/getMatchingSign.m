function [ signImage ] = getMatchingSign( id )
%GETMATCHINGSIGN Summary of this function goes here
%   Detailed explanation goes here

    I = imread('../data/bdd.jpg');
    R = load('learningRectangles.mat','-ascii');
    signImage = I(R(id,2) : R(id,4),(R(id,1) : R(id,3)));
        
end

