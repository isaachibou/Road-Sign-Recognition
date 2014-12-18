close all;
clear;
clc;

%% RoadSignRecognition
% Application written to recognize road signs on french roads.
% May be use for one picture, or a folder of picture.

roadsign = imread('../data/crossing_007.png');

% Declaration of structure
panels = struct('image', {}, 'shape', {}, 'color1', {}, 'color2', {}, 'id', {});

%% Circular Pannels

[Circle1, Circle2, Circle3] = circleDetection(roadsign);

panels(1).image = Circle1;
panels(2).image = Circle2;
panels(3).image = Circle3;
    
% most likely
panels(1).shape = 'circular';
panels(2).shape = 'circular';
panels(3).shape = 'circular';

%% Color Detection

I = colordetection( roadsign);
figure 
imshow(I);

BW = edge(I,'canny');

[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','green');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

 

%% Triangles + Squares

%% Color detection
colordetection(panels);

%% Compare
