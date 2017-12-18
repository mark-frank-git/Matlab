function  [a b r] = circle_regression(iqData, first_iterations, iterations)
% **********************************************************************
% function circle_regression(iqData, first_iterations, iterations)
%
%
% Description:
% -----------
% Calculate circle parameters from IQ data around a circle (e.g., 8-PSK data)
%
% Input variables:
% -----------------------
%  iqData           : Input IQ data around a circle
%  first_iterations : Iterations for first circle
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
kNUMBER_CIRCLES     = 16;
kNUMBER_THRESHOLDS  = 16;                   % 16 for unrotated EDGE signal
%
% Sort the data so we don't get colinear points
%
iq_angle            = atan2(imag(iqData), real(iqData));
[iq_angle idx]      = sortrows(iq_angle', 1);
iq_sorted           = iqData';
iq_sorted           = iq_sorted(idx);
iq_real             = real(iq_sorted);
iq_imag             = imag(iq_sorted);
%
% Find the phase thresholds:
%
thresholds          = find_phase_thresholds(iq_angle, kNUMBER_THRESHOLDS);
%
% Find the averaged points
%
[x_avg, y_avg]      = find_averaged_points(thresholds, iq_angle, iq_sorted);
x_avg               = [x_avg x_avg];
y_avg               = [y_avg y_avg];
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
k                   = 1;
max_k               = length(x_avg) - 2;
kALPHA              = .1;
kBETA               = 0.1;
k                   = 1;
for i=1:kNUMBER_CIRCLES
  x_points          = x_avg(k:k+2);
  y_points          = y_avg(k:k+2);
  circle_parameters     = circle_average;
%  Loop over the number of iterations to refine the new circle
  for j=1:iterations
    J                   = generate_JacobianSq(x_points, y_points, circle_parameters);
    F                   = generate_Fsq(x_points, y_points, circle_parameters);
    delta_parameters    = J\F;
    circle_parameters   = circle_parameters - kALPHA*delta_parameters';
  end;
  if(i==1)
    circle_average      = circle_parameters;
  else
    circle_average      = (1-kBETA)*circle_average + kBETA*circle_parameters;
  end

  x(i)                  = circle_parameters(1);
  y(i)                  = circle_parameters(2);
  k                     = k+1;
  if k > max_k
    k                   = 1;
  end
end
%
% Get the updated outputs
%
%circle_average      = circle_average ./ kNUMBER_CIRCLES;
a                   = circle_average(1);
b                   = circle_average(2);
r                   = circle_average(3);
figure(999)
scatter(iq_real, iq_imag);
plot_circle(x_avg, y_avg, circle_average, 1);

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
% Plot 3 points
%
scatter(x_points, y_points);
axis([-r-100 r+100 -r-100 r+100]);
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
plot(x, y);
hold all;
return;
