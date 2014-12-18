function [ Rectangles ] = seekRectangles( I,Lignes,Colonnes)
%DŽtermination du rectangle le plus pr?s du chiffre
    nbLignes=size(Lignes,1);
    nbCol=size(Colonnes,2);
    Rectangles=zeros(nbLignes*nbCol,4);
    k=1;
    
    % Rectangle au plus pr?s du chiffre
    for i=1:nbLignes
       for j=1:2:nbCol-1
            %On corrige la ligne pour toucher le panneau
            %La colonne c'est bon
            L=seekLines(I(Lignes(i,1):Lignes(i,2),Colonnes(i,j):Colonnes(i,j+1)));
            Rectangles(k,1)=Colonnes(i,j);


            Rectangles(k,2)=L(1,1)+Lignes(i,1);
            Rectangles(k,3)=Colonnes(i,j+1);
            Rectangles(k,4)=L(1,2)+Lignes(i,1);

          k=k+1;
       end
    end

end

