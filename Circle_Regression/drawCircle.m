function drawCircle(a, x, y, figureNumber)
% **********************************************************************
% function drawCircle(a, x, y, figureNumber)
%
% draws circle and points
%
% Description:
% -----------
% Draw circle
%
% Input variables:
% -----------------------
%  a                : A, B, C: x^2 + y^2 = Ax + By + C
%  x                : x points on circle
%  y                : y points on circle
%  figureNumber     : Figure #
%
% Output variables:
% -----------------------
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% http://www.had2know.com/academics/best-fit-circle-least-squares.html
%
% Revision History
% ----------------
%  - Jan. 16, 2013 - Started
% *************************************************************************
figure(figureNumber);
h       = a(1)/2;
k       = a(2)/2;
r       = sqrt(a(3)+h*h+k*k);
%
% Plot points on circle
%
scatter(x, y);
axis([-1.2*r 1.2*r -1.2*r 1.2*r]);
figure(figureNumber);
grid on;
hold all;
%
% plot circle
%
x_min   = h - r + 1;
x_max   = h + r - 1;
x_start = linspace(x_min, x_max,200);
x_end   = linspace(x_max, x_min,200);
y_start = -sqrt(r^2 - (x_start - h).^2) + h;
y_end   = sqrt(r^2 - (x_end - h).^2) + h;
x       = [x_start x_end];
y       = [y_start y_end];
p       = plot(x, y);
set(p,'Color','red','LineWidth',2)
return;
