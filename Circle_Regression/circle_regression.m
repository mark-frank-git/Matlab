function  [a b r] = circle_regression(iqData, iterations)
% **********************************************************************
% function circle_regression(iqData, iterations)
%
%
% Description:
% -----------
% Calculate circle parameters from IQ data around a circle (e.g., 8-PSK data)
%
% Input variables:
% -----------------------
%  iqData           : Input IQ data around a circle
%  iterations       : number of iterations to run Newton Raphson
%
% Output variables:
% -----------------------
%  a                : x location of circle center
%  b                : y location of circle center
%  r                : circle radius
%
% Notations:
% ----------
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% Newton Raphson solution of non-linear equations
%
% Revision History
% ----------------
%  - Jan. 8, 2013 - Started
% *************************************************************************
%
% Set up
%
kNUMBER_UNKNOWNS    = 3;
kINC                = 5;
%
% Sort the data so we don't get colinear points
%
iq_angle            = atan2(imag(iqData), real(iqData));
[iq_angle idx]      = sortrows(iq_angle', 1);
iq_sorted           = iqData';
iq_sorted           = iq_sorted(idx);
iq_real             = real(iq_sorted);
iq_imag             = -imag(iq_sorted);
%
% Initialize the circle parameters
%
a                   = 0;
b                   = 0;
r                   = 1.1*sqrt(iq_real(10)^2 + iq_imag(10)^2);  % Pick one point on the circle
circle_parameters   = [a, b, r];
circle_average      = circle_parameters;
%
%
max_k               = length(iq_real);
kALPHA              = 1;
kBETA               = 0.1;
k                   = 1;
numberCircles       = floor(length(iq_angle)/kINC);
for i=1:numberCircles
  [x_points y_points]   = find_new_points(iq_angle, k, iq_real, iq_imag);
%  Loop over the number of iterations to refine the new circle
  for j=1:iterations
    F                   = generate_Fsq(x_points, y_points, circle_parameters);
    J                   = generate_JacobianSq(x_points, y_points, circle_parameters);
    delta_parameters    = J\F;
    circle_parameters   = circle_parameters - kALPHA*delta_parameters';
  end;
  if(i==1)
    circle_average      = circle_parameters;
  else
%    circle_average      = kBETA*circle_parameters + (1-kBETA)*circle_average;
    circle_average      = circle_average + circle_parameters;
  end
 
  x(i)                  = circle_parameters(1);
  y(i)                  = circle_parameters(2);
  k                     = k+kINC;
  if k > max_k
    k                   = 1;
  end
end
%
% Get the updated outputs
%
circle_average      = circle_average/numberCircles;
a                   = circle_average(1);
b                   = circle_average(2);
r                   = circle_average(3);
r                   = mean(abs(iqData));
circle_average(3)   = r;
iq_offset           = 100*sqrt(a^2 + b^2)/r
plot_circle(real(iqData), imag(iqData), circle_average, 999);
a                   = fitCircle(real(iqData)', imag(iqData)');
h                   = a(1)/2;
k                   = a(2)/2;
r                   = sqrt(a(3)+h*h+k*k)
iq_offset           = 100*sqrt(h*h+k*k)/r
drawCircle(a, real(iqData)', imag(iqData)', 1001);
return;

function  plot_circle(x_points, y_points, circle_parameters, figure_number)
% **********************************************************************
% function plot_circle(x_points, y_points, circle_parameters, figure_number)
%
%
% Description:
% -----------
% Plots 3 points on the circle along with the circle
%
% Input variables:
% -----------------------
%  x_points         : X values of 3 points
%  y_points         : Y values of 3 points
%  circle_parameters: (a, b, r): circle x center, y center, radius
%  figure_number    : Figure number for plotting
%
% Output variables:
% -----------------------
%  None
%
% Notations:
% ----------
%
% Calls:
% -----------
%  None
%
% Revision History
% ----------------
%  - Jan. 15, 2013 - Started
% *************************************************************************
figure(figure_number);
a       = circle_parameters(1);
b       = circle_parameters(2);
r       = circle_parameters(3);
%
% Plot points on circle
%
scatter(x_points, y_points);
axis([-1.2*r 1.2*r -1.2*r 1.2*r]);
figure(figure_number);
grid on;
hold all;
%
% plot circle
%
x_min   = a - r + 1;
x_max   = a + r - 1;
x_start = linspace(x_min, x_max,200);
x_end   = linspace(x_max, x_min,200);
y_start = -sqrt(r^2 - (x_start - a).^2) + b;
y_end   = sqrt(r^2 - (x_end - a).^2) + b;
x       = [x_start x_end];
y       = [y_start y_end];
p       = plot(x, y);
set(p,'Color','red','LineWidth',2)
return;
