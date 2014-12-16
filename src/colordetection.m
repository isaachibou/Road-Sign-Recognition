function [ Ibinary ] = colordetection( I )
%COLORDETECTION
    %   Finds the color of the sign, between white, blue and red
    I=rgb2hsv(I);

    %Color H S V
    %Red H?240 or H?10 S?40 V?30
    % 0.05<= H <= 0.97 0.3<=S<=1 0.01<=V<= 1;
    %Yellow 18?H?45 S?148 V?66
    %Blue 120<H?175 S?127.5 V?20 
    %bluePixels = hueImage > 0.4 & hueImage < 0.7 & valueImage < 0.8;

    s=size(I);

    IR = uint8(zeros(s));
    for i=1:s(1)
    for j=1:s(2)
        if ((I(i,j,1)>=240/255 || I(i,j,1)<=10/255) && I(i,j,2)>=40/255 && I(i,j,3)>=30/255 )
            IR(i,j,:)=255;
        end
    end
    end

    IB = uint8(zeros(s));
    for i=1:s(1)
    for j=1:s(2)
        if ((I(i,j,1)>120/255 && I(i,j,1)<=175/255 ) && I(i,j,2)>=127.5/255 && I(i,j,3)>=20/255 )
            IB(i,j,:)=255;
        end
    end
    end

    
    %erosion 
    SE1=[0 1 0; 1 1 1; 0 1 0];
    IR=imerode(IR,SE1);
    IB=imerode(IB,SE1);
   
    Ibinary=rgb2gray(IR+IB);
    
end