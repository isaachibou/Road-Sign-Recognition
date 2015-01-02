function [ Result ] = computeDensities( I,Rectangles,m,n)
% Calcul de la densité de chaque chiffre
    Result=[];

    for o=1:size(Rectangles,1)
        A= I(Rectangles(o,2):Rectangles(o,4),(Rectangles(o,1):Rectangles(o,3)));
        
        [l,c]=size(A);

        col=floor(linspace(1,c,m+1));
        lin=floor(linspace(1,l,n+1));

        endCol=size(col,2)-1;
        endLin=size(lin,2)-1;

        % Densité = moyenne niveau gris dans la zone
        k=1;
        V=ones(1,m*n);

        for i=1:endCol
            for j=1:endLin
                V(1,k)=mean(mean(A(lin(j):lin(j+1),col(i):col(i+1))));
                k=k+1;
            end
        end

        Result(o,:) = V;
    end
end

