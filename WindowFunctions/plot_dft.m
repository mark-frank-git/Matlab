function plot_dft(frequency, dftMagnitude, figureNumber, figureTitle)
% **********************************************************************
% function plot_dft(frequency, dftMagnitude, figureNumber)
%
% Plots the Fourier transform of the window function
%
% Input variables:
% -----------
% frequency     : digital frequency points
% dftMagnitude  : DFT magnitude to plot
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
maxMag        = max(dftMagnitude);
dftMagnitude  = dftMagnitude/maxMag;
%
% Plot DFT of window function
%
figure(figureNumber), clf, hold all
p     = plot(frequency, 10.*log10(dftMagnitude));
grid on, zoom on
ylabel('Magnitude in dB');
xlabel('Digital Frequency');
ylim([-100 0]);
xlim([-3 3]);
title(figureTitle);
set(p,'Color','blue','LineWidth',0.5)

return;
