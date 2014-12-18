function [ Col ] = seekColumns( I, Lignes )
%Recherche des colonnes dans l'image
%Ligne par lgne pour etre au plus pres du chiffre
    col=size(I,2);
    lineI=size(Lignes,1);
    
    % Ligne par ligne
    for j=1:lineI 
 
         p = 1;
         IA = I(Lignes(j,1):Lignes(j,2), 1:col);
         % Nombre de pixels non noirs
         S = sum(IA>50);

         k=1;
         % On sauvegarde les coordonnées
         while k <= col 

             if S(k) ~= 0
                Col(j,p) = k;

                while ( k <= col && S(k) ~= 0 )
                    k = k+1;
                end

                if k <= col
                    p = p+1;
                    Col(j,p) =k;
                    p = p+1;
                end
             end

             k = k + 1;
         end
    end
end

