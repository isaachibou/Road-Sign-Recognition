function [ densities ] = apprentissage(m,n)

    %Image d'apprentissage
    I=imread('../data/BaseRond.jpg');

    %Rectangles
    L = seekLines(I);
    nbL = size(L,1);
    C = seekColumns(I, L);
    nbC = size(C,2)/2;
    R=seekRectangles(I,L,C);


    %Calcul des vecteurs densités
    densities=computeDensities(I, nbL,nbC, R, m, n);
    save('Densities.mat','densities','-ascii');
    
end