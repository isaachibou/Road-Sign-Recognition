clear;

% Nombre de lignes par chiffre � utiliser

% Etablissement de la base d'apprentissage
% Valeurs conseill�es par l'�nonc�
m=6;
n=6;
if ~exist('learningDensities.mat', 'file')
    learningPhase(m,n);
end
%Image de test
I=imread('../data/station.jpg');

%Rectangles
R=[1 1 size(I,2) size(I,1)];

% Densit�s image de travail
Densities = computeDensities(I, R, m, n);

% Comparaison pour trouver la classe
base=load('learningDensities.mat','-ascii');
res=seekClass(Densities,base);

res
    
    
    
    