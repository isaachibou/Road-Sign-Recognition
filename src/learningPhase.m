function [ densities ] = learningPhase(m,n,shape)

    % Image d'apprentissage
    I = imread(strcat('../data/bdd_', shape, '.png'));

    % Rectangles
    L = seekLines(I);
    C = seekColumns(I, L);
    R = seekRectangles(I,L,C);
    save(strcat('learningRectangles_', shape,'.mat'),'R','-ascii');

    % Calcul des vecteurs densités
    densities = computeDensities(I, R, m, n);
    save(strcat('learningDensities_', shape,'.mat'),'densities','-ascii');
    
end