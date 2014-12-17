function [ Ibinary ] = colordetection( I )
%return grayscale image after tresholding with blue and red pixels in white 
   
    I=rgb2hsv(I);

    %Color H S V
    %Red H?240 or H?10 S?40 V?30
    %((I(i,j,1)>=240/255 || I(i,j,1)<=10/255) && I(i,j,2)>=40/255 && I(i,j,3)>=30/255 )
    %Yellow 18?H?45 S?148 V?66
    %Blue 120<H?175 S?127.5 V?20 
    %bluePixels = hueImage > 0.4 & hueImage < 0.7 & valueImage < 0.8;

    s=size(I);
    
    I(73,246,:)

    IR = uint8(zeros(s));
    for i=1:s(1)
    for j=1:s(2)
        if ((I(i,j,1)>=235/255 || I(i,j,1)<=15/255) && I(i,j,2)>=40/255 && I(i,j,3)>=30/255 )
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

    IR=rgb2gray(IR);
    IB=rgb2gray(IB);

    %erosion 
    SE1=[0 1 0; 1 1 1; 0 1 0];
    se = strel('disk',4);
    IR=imerode(IR,SE1);
    IB=imerode(IB,SE1);

    IR=imclose(IR,se);
    IB=imclose(IB,se);
    figure
    imshow(IR+IB);
   
    Ibinary=IB+IR;
    
end