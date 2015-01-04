function [ profile ] = seekProfiles( I, rectangles, d ,draw)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    s = size(rectangles,1);
    profile = zeros(s,d*2);
    
    if draw==1
        figure
        imshow(I)
        hold on
    end
    
    for i=1:s
       w = rectangles(i,3) - rectangles(i,1);
	   pts = floor(linspace(rectangles(i,2), rectangles(i,4),d));
       %pour chaque chiffre, on le divise en d parties
        for j=1:d
            %profil gauche

            % abscisse de départ
            k=rectangles(i,1);
            
            % Jusqu'à trouver blanc
            find=false;
            while k <= rectangles(i,3) && not(find)
                if I(pts(j),k)==1
                    find=true;
                else    
                    k=k+1;
                end
            end
            
            % Jusqu'à trouver du noir
            while k <= rectangles(i,3) && I(pts(j),k)~=0
                k=k+1;
            end
            % abscisse de l'arrivée
            gauche=k;

            % dessin
            if draw == 1
                plot([rectangles(i,1),gauche],[pts(j),pts(j)],'Color','r','LineWidth',2);
            end

            %profil droit
            k=rectangles(i,3);
           
             % Jusqu'à trouver blanc
             find=false;
            while k >= rectangles(i,1) && not(find)
                if I(pts(j),k)==1
                    find=true;
                else    
                    k=k-1;
                end
            end
            
            while k >= rectangles(i,1) && I(pts(j),k)~=0
                k=k-1;
            end
            droite=k;

            % dessin
            if draw == 1
                plot([rectangles(i,3),droite],[pts(j),pts(j)],'Color','b','LineWidth',2);
            end

            profile(i,j)=(gauche-rectangles(i,1))/w;
            profile(i,j+d)=(rectangles(i,3)-droite)/w;
        end
    end
    
    if draw==1
        hold off
    end

end

