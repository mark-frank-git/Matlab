function plot_time_domain(window, figureNumber, figureTitle)
% **********************************************************************
% function plot_time_domain(window, figureNumber, figureTitle)
%
% Plots the window function
%
% Input variables:
% -----------
% window        : Window to plot
% figureNumber  : plot figure number
% figureTitle   : title of figure
%
% Output variables:
% -----------------------
% None
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
% First, normalize
% Normalize
maxMag        = max(window);
window        = window/maxMag;
sizeWindow    = length(window);
x             = linspace(-1, 1, sizeWindow);
%
% Plot window function
%
figure(figureNumber), clf, hold all
p     = plot(x, window);
grid on, zoom on
ylabel('Magnitude');
xlabel('Time');
ylim([0 1]);
xlim([-1.1 1.1]);
title(figureTitle);
set(p,'Color','blue','LineWidth',1.0)

return;
