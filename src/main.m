clear;

% Nombre de lignes par chiffre à utiliser
d=6;


% Etablissement de la base d'apprentissage
% Valeurs conseillées par l'énoncé
m=6;
n=6;
apprentissage(m,n);

%Image de test
I=imread('../data/testgris.jpg');

%Rectangles
L = seekLines(I);
nbL = size(L,1);
C = seekColumns(I, L);
nbC = size(C,2)/2;
R=seekRectangles(I,L,C);

% Densités image de travail
Densities = computeDensities(I, nbL,nbC, R, m, n);

% Calcul scientifique trop fort
base=load('Densities.mat','-ascii');
res=seekClass(Densities,base);


res
    
    
    
    