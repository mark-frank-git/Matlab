function  plot_freq_response(magResponse, figureNumber, plotTitle)
%
% function  plot_freq_response(magResponse, figureNumber, plotTitle)
%
% Plots the frequency response of a digital filter
%
% Description:
% ------------
%  Plot response
%
% Input variables:
% ----------------
%  magResponse		: response to plot
%  figureNumber		: Figure number to use
%  title		: Title of plot
%
% Output variables:
% -----------------
%  None
%
% Calls:
% -----------------
%  None
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%
% Revision History
% ----------------
%  - Aug 7, 2009 - Started.
% *****************************************************************************
%
%
figure(figureNumber), clf, hold off
xValues			= linspace(0, pi, length(magResponse));
plot(xValues, 20.*log10(abs(magResponse)));
xlabel('Digital Frequency');
ylabel('Magnitude in dB');
grid on;
title(plotTitle);
return;
