function [ id ] = distEuclid( profiles,base )
    l=size(base,1);
    
    distances=zeros(l);
    
    % chgt de chiffre toutes les d*2 lignes
   for i=1:l        
        v = profiles(1,:)-base(i,:);
        distances(i)=sqrt(sum(v.^2));
   end
   
   [~,id] = min(distances);
end

