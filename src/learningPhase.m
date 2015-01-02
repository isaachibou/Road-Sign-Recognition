function [ densities ] = learningPhase(m,n)

    % Image d'apprentissage
    I = imread('../data/bdd.jpg');

    % Rectangles
    L = seekLines(I);
    C = seekColumns(I, L);
    R = seekRectangles(I,L,C);

    % Calcul des vecteurs densités
    densities = computeDensities(I, R, m, n);
    save('learningDensities.mat','densities','-ascii');
    
end