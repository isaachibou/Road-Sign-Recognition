function [ profile ] = baseProfiles( Icolor, rectangles, d ,draw)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    s = size(rectangles,1);
    profile = zeros(s,d*2);
    
    for i=1:s
       I = getIndoor(Icolor(rectangles(i,2):rectangles(i,4),rectangles(i,1):rectangles(i,3),:));
       [l,c] = size(I);
       pts = floor(linspace(1, l,d));
       if draw==1
           figure
           imshow(I)
           hold on
       end
       %pour chaque chiffre, on le divise en d parties
        for j=1:d
            %profil gauche

            % abscisse de départ
            k=1;
            
            % Jusqu'à blanc
            find=false;
            while k <= c && not(find)
                if I(pts(j),k)==1
                    find=true;
                else    
                    k=k+1;
                end
            end
            
            % Jusqu'à trouver du noir
            while k <= c && I(pts(j),k)~=0
                k=k+1;
            end
            % abscisse de l'arrivée
            gauche=k;

            % dessin
            if draw == 1
                plot([1,gauche],[pts(j),pts(j)],'Color','r','LineWidth',2);
            end

            %profil droit
            k=c;
           
             % Jusqu'à trouver blanc
             find=false;
            while k >= 1 && not(find)
                if I(pts(j),k)==1
                    find=true;
                else    
                    k=k-1;
                end
            end
            
            while k >= 1 && I(pts(j),k)~=0
                k=k-1;
            end
            droite=k;

            % dessin
            if draw == 1
                plot([c,droite],[pts(j),pts(j)],'Color','b','LineWidth',2);
            end

            profile(i,j)=(gauche-1)/c;
            profile(i,j+d)=(c-droite)/c;
        end
    end
    
    if draw==1
        hold off
    end

end

