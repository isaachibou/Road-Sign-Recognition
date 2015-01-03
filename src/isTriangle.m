function [ answer ] = isTriangle( lines,horizontalLines )
%isTriangle 
%   return if there is a triangle defined by lines 

    %parameters
    angleError=5;
    normError=10;

    c=size(lines,2);%number of lines
    ch=size(horizontalLines,2);%number of horizontal lines
    answer=false;
    
    %for each horizontal line
    for i=1:ch
       for j=1:c
          % find a line with abs(theta)=30
          if abs(lines(j).theta)>=30-angleError && abs(lines(j).theta)<=30+angleError
              for k=j+1:c
                  %find a line with opposite angle at the first
                  if (lines(j).theta>0 && lines(k).theta>=-30-angleError && lines(k).theta<=-30+angleError) || (lines(j).theta<0 && lines(k).theta>=30-angleError && lines(k).theta<=30+angleError)
                      %find 3 points of triangle
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

