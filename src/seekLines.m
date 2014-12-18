function [ Lignes ] = seekLines( I )
%Recherche des lignes dans l'image
    line = size(I,1);
    
    %Nombre de pixels non noirs
    S = sum(I~=0,2);
  
    %100x2 lignes à trouver, début - fin
    Lignes = zeros(100,2);
    p = 1;
    
    i=1;

    %On sauvegarde les indices
    while i <= line
        
         if S(i) ~= 0 
            Lignes(p,1) = i;

            while ( i<= line && S(i) ~= 0 ) 
               i=i+1;
            end

            if i<= line 
                Lignes(p,2) = i;
                p = p+1;
            end
         end

         i= i +1;
    end
    
end

