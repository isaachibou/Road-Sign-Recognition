clear;

% Nombre de lignes par chiffre à utiliser

% Etablissement de la base d'apprentissage
% Valeurs conseillées par l'énoncé
m=6;
n=6;
learningPhase(m,n);

%Image de test
I=imread('../data/testgris2.jpg');

%Rectangles
%L = seekLines(I)
%nbL = size(L,1);
%C = seekColumns(I, L)
%nbC = size(C,2)/2;
R=[1 1 size(I,2) size(I,1)];

% Densités image de travail
Densities = computeDensities(I,1,1, R, m, n);

% Calcul scientifique trop fort
base=load('learningDensities.mat','-ascii');
res=seekClass(Densities,base);

res
    
    
    
    