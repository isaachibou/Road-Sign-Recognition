function [ resultatMagique ] = seekClass( Densities, base)
%Blablabla
    nbZones=size(Densities,1);
    nbb=size(base,1);
    diff = zeros(nbb,1);
    for i=1:nbb
        blabla = 0;
        blabla2 = 0;
        for j=1:nbZones
            if j == 1
                blabla2 = Densities(j) - base(i,j); %Premiere valeur
            else
                blabla += blabla2 - (Densities(j) - base(i,j)); %Precedente valeur - Actuelle
                blabla2 = Densities(j) - base(i,j); %Sauvegarde valeur actuelle
            end
        end
        diff(i) = blabla
    end
    resultatMagique = find(a==min(min(diff)));
end

