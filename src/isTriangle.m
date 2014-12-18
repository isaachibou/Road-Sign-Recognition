function [ answer ] = isTriangle( lines,horizontalLines )
%isTriangle 
%   return if there is a triangle defined by lines 

    %parameters
    angleError=10;
    normError=10;

    c=size(lines,2);
    ch=size(horizontalLines,2);
    answer=false;
    for i=1:ch
       for j=1:c
          if abs(lines(j).theta)>=30-angleError && abs(lines(j).theta)<=30+angleError
              for k=j+1:c
                  if (lines(j).theta>0 && lines(k).theta>=-30-angleError && lines(k).theta<=-30+angleError) || (lines(j).theta<0 && lines(k).theta>=30-angleError && lines(k).theta<=30+angleError)
                      A=findIntersection(lines(j),horizontalLines(i));
                      B=findIntersection(lines(k),horizontalLines(i));
                      C=findIntersection(lines(j),lines(k));
                      
                      AB=round(norm(B-A));
                      AC=round(norm(C-A));
                      BC=round(norm(C-B));
                      
                      if abs(AB-AC)<normError && abs(AB-BC)<normError
                          answer=true;
                          return;
                      end
                  end
              end
              
          end
       end
    end

end

