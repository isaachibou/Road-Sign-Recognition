clear;

% Nombre de lignes par chiffre à utiliser

% Etablissement de la base d'apprentissage
% Valeurs conseillées par l'énoncé
m=6;
n=6;
if ~exist('learningDensities.mat', 'file')
    learningPhase(m,n);
end
%Image de test
I=imread('../data/station.jpg');

%Rectangles
R=[1 1 size(I,2) size(I,1)];

% Densités image de travail
Densities = computeDensities(I, R, m, n);

% Comparaison pour trouver la classe
base=load('learningDensities.mat','-ascii');
res=seekClass(Densities,base);

res
    
    
    
    