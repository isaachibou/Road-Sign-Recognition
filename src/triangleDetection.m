function [ triangles ] = triangleDetection( I )
%triangleDetection 
%return vector of structure sign 
    Ihsv=rgb2hsv(I);
    s=size(I);
    
    triangles = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});
    index=1;

    IR = uint8(zeros(s));
    for i=1:s(1)
        for j=1:s(2)
            if ((Ihsv(i,j,1)>=235/255 || Ihsv(i,j,1)<=15/255) && Ihsv(i,j,2)>=40/255 && Ihsv(i,j,3)>=30/255 )
                IR(i,j,:)=255;
            end
        end
    end
    
    Ib=rgb2gray(IR);
    
    %end red tresh
    
    [lmax,cmax]=size(Ib);
    Ifill=imfill(Ib);
    [Ilabel, num ]=bwlabel(Ifill);

    Iprops=regionprops(Ilabel,'BoundingBox');
    Ibox=[Iprops.BoundingBox];
    Ibox=reshape(Ibox,[4 num]);
    
    for i=1:num 
        if Ibox(3,i)>=20 && Ibox(4,i)>=20
            l=floor(Ibox(2,i));
            l2=ceil(Ibox(2,i)+Ibox(4,i));
            c=floor(Ibox(1,i));
            c2=ceil(Ibox(1,i)+Ibox(3, i));

            if l<1
               l=1; 
            end

            if l2>lmax
               l2=lmax; 
            end

            if c<1
                c=1;
            end

            if c2>cmax
                c2=cmax;
            end

            Itemp=Ib( l:l2, c:c2,:);
            
            BW = edge(Itemp,'canny');
            [H,T,R] = hough(BW);

            P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

            lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
            hlines=horizontalLines(lines);

            if not(isempty(hlines(1).point1))
               if isTriangle(lines,hlines);
                   triangles(index) = struct('image', I(l:l2, c:c2,:), 'shape', 'triangular', 'color1', 'red', 'color2', '', 'id', '');
                   index=index+1;
                   
                   figure
                   imshow(Itemp)
                    hold on
                    for k = 1:length(lines)
                       xy = [lines(k).point1; lines(k).point2];
                       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
                    end
                    hold off
               end
            end
           
           
        end
    end

end

