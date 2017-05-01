%% 2016-06-29 TRADE_OFF by Julian
% Calculates the distance between the dual-task means and single-task
% connection using trigonometry. Distance is equivalent to height of
% triangle between known ST and DT mean coordinates.
%
% Function also produces x and y coordinates of intersect for plotting
%
% Quite a bit of redundancy in this script, wanted to be certain the
% correct heights and coordinates are being computed


function [height,x,y,col] = trade_off(ST_Central,ST_Peripheral,DT_Central,DT_Peripheral,chance_value)

if nargin == 4
    chance_value = 0.5;
end

% Chance lines
central_chance = chance_value;
peripheral_chance = chance_value;

% Define points A, B, C where C is dual-task point
A = [central_chance, ST_Peripheral]; % A(x,y)
C = [DT_Central, DT_Peripheral]; % B(x,y)
B = [ST_Central, peripheral_chance]; % C(x.y)

% Calculate area of triangle
tri_area_sanity = abs((A(1)*(C(2)-B(2))+C(1)*(B(2)-A(2))+B(1)*(A(2)-C(2)))/2);

% Triangle coordinates:
% [Chance peripheral intersect, Dual-task means, Chance central intersect]
points = [central_chance,ST_Peripheral;DT_Central,DT_Peripheral;ST_Central,peripheral_chance];

% Calculate area of triangle and length of connecting line (tri_base)
tri_area = polyarea(points(:,1),points(:,2)); % OK

% 'D' represents intersect of line AB from point C
% Calculate slope of AB
slope_AB = (B(2)-A(2))/(B(1)-A(1));
slope_CD = -(1/slope_AB);

% Equation for line CD
% y = m*x + b therefore C(2)=slope_CD*(C(1))+b or b = C(2)-slope_CD*(C(1))
% Therefore equation for line CD
% y = slope_CD*(x) + (C(2)-slope_CD*(C(1)))

% Equation for line AB
% y = m*x + b therefore A(2)=slope_AB*(A(1))+b or b = A(2)-slope_AB*(A(1))
% Therefore equation for line AB
% y = slope_AB*(x) + (A(2)-slope_AB*(A(1)))

% Solve for CD(x) = AB(x)
% slope_CD*(x) + (C(2)-slope_CD*(C(1))) = slope_AB*(x) + (A(2)-slope_AB*(A(1)))
% slope_CD*(x) = slope_AB*(x) + (A(2)-slope_AB*(A(1))) - (C(2)-slope_CD*(C(1))) 
% slope_CD*(x) - slope_AB*(x) = (A(2)-slope_AB*(A(1))) - (C(2)-slope_CD*(C(1)))
% x*(slope_CD - slope_AB) = (A(2)-slope_AB*(A(1))) - (C(2)-slope_CD*(C(1)))

CD_x = ((A(2)-slope_AB*(A(1))) - (C(2)-slope_CD*(C(1))))/(slope_CD - slope_AB); %OK
CD_y = slope_CD*(CD_x) + (C(2)-slope_CD*(C(1))); %OK

xC = C(1);
yC = C(2);
xD = CD_x;
yD = CD_y;

another_height_sanity = sqrt((xD-xC)^2 + (yD-yC)^2); %OK

 

% Distance between points (pythagorus) = sqrt((x2-x1)^2 + (y2-y1)^2)
x1 = central_chance;
y1 = ST_Peripheral;
x2 = ST_Central;
y2 = peripheral_chance;

STP_STC_sanity = sqrt((x2-x1)^2 + (y2-y1)^2);

% Peripheral intersect to DT-means
x1 = central_chance;
y1 = ST_Peripheral;
x2 = DT_Central;
y2 = DT_Peripheral;

STP_DT_sanity = sqrt((x2-x1)^2 + (y2-y1)^2);

% DT-means to central intersect
x1 = DT_Central;
y1 = DT_Peripheral;
x2 = ST_Central;
y2 = peripheral_chance;

DT_STC_sanity = sqrt((x2-x1)^2 + (y2-y1)^2);

% semiperimeter = (a+b+c)/2
semiperimeter = (STP_STC_sanity+STP_DT_sanity+DT_STC_sanity)/2;

% Height from side a using sides and semiperimeter
% Ha = (2*sqrt(s(s-a)(s-b)(s-c)))/a
a=STP_STC_sanity;
b=STP_DT_sanity;
c=DT_STC_sanity;
s = 0.5*(a+b+c);

area = sqrt(s*(s-a)*(s-b)*(s-c)); %OK
height = (2*sqrt(s*(s-a)*(s-b)*(s-c)))/a; %OK


tri_base = sqrt((ST_Central-chance_value)^2+(chance_value-ST_Peripheral)^2);
height_sanity = 2*(tri_area/tri_base); 
% 
% Intersect coordinates with hypotenuse
intersect = height/sqrt(2); % Has to have problems

% Check if DT coordinates fall inside chance-line triangle
inside = inpolygon(DT_Central,DT_Peripheral,...
    [central_chance,central_chance,ST_Central],...
    [ST_Peripheral,peripheral_chance,peripheral_chance]);

% Check if DT coordinates fall above chance-lines
outside = inpolygon(DT_Central,DT_Peripheral,...
    [central_chance,central_chance,1,1,ST_Central,central_chance],...
    [ST_Peripheral,1,1,peripheral_chance,peripheral_chance,ST_Peripheral]);

% Define intersect points
x = CD_x;
y = CD_y;

% Does intersect fall behind chance line?
% Height is negative in this instance
if outside   
    % Set colour for intersect line
    col = 'b';
elseif inside
    % Set colour for intersect line
    col = 'r';
    % Convert height into a negative value
    height = -height;
else
    % Set colour for intersect line
    col = 'r';
    % Convert height value to a negative,
    % DT_Central performance will almost always be lower than ST_Central if
    % DT_Peripheral is below chance
    if DT_Central > CD_x && DT_Peripheral > CD_y
        col = 'b';
    else
        height = -height;
    end
end

end