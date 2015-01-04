function [ Ib ] = getIndoor( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Ihsv=rgb2hsv(I);

    [l,c,~]=size(I);
    IR = uint8(zeros(l,c));
    for g=1:l
        for p=1:c
            if ((Ihsv(g,p,1)>=235/255 || Ihsv(g,p,1)<=15/255) && Ihsv(g,p,2)>=40/255 && Ihsv(g,p,3)>=30/255 )
                IR(g,p,:)=255;
            end
        end
    end
    
    Ifill=imfill(IR)/255;
    IR=imcomplement(IR)/255;
    Ib=rgb2gray(I).*IR.*Ifill;
    Ib=im2bw(Ib,graythresh(Ib));
end

