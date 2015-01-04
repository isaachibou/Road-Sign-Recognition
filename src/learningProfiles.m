function [ profiles ] = learningProfiles( d )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    I = imread(strcat('../data/bdd_triangular.png'));
    I = rgb2gray(I);
  
    % Rectangles
    L = seekLines(I);
    C = seekColumns(I, L);
    R = seekRectangles(I,L,C);
    save(strcat('learningRectangles_triangular.mat'),'R','-ascii');

    % Calcul des vecteurs densités
    I = imread(strcat('../data/bdd_triangular_color.png'));
    profiles = baseProfiles(I, R, d,0);
    save(strcat('learningProfiles_triangular.mat'),'profiles','-ascii');

end

