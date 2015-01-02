% I = imread('pedestrian_00.png');
% IB = colordetection(I);
% 
% st = regionprops(IB, 'BoundingBox' );
% for k = 1 : length(st) 
%     thisBB = st(k).BoundingBox;
%     rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)]);
% end
% rectangle('Position',[st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)],...
% 'EdgeColor','r','LineWidth',2 )

clc = imread('pedestrian_010.png');
IB = colordetection(clc);
BW = IB(:,:,1);
BW = imfill(BW, 'holes');
imshow(BW)
[label, num] = bwlabel(BW);
st = regionprops(label, 'BoundingBox' ); 
props = [st.BoundingBox];
num
props = reshape(props, [4 num]);
figure
hold on
imshow(IB);

for i = 1:num
    if(props(3,i)<10 || props(4,i)<10)
    elseif (props(3,i)/props(4,i) > 1.5 || props(4,i)/props(3,i) > 1.5)
    else 
       rectangle('Position', props(:,i), 'EdgeColor', 'r');
    end
end
% for k = 1 : length(st) 
%     thisBB = st(k).BoundingBox; 
%     rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)], 'EdgeColor','r','LineWidth',2 )
% end