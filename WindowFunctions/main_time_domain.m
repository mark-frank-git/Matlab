function  main_time_domain()
% **********************************************************************
% function main_time_domain()
%
% Main program for plotting the time response of the window functions
%
% Description:
% -----------
% Main driver
%
% Calls:
% -----------
% plot_time_window
%
% References:
% -----------
% None
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
% Set up
%
windowLength  = 200;

% Rectangular
window  = rectwin(windowLength);
plot_time_domain(window, 5, 'Rectangular Window');

%Hann
window  = hann(windowLength);
plot_time_domain(window, 6, 'Hann Window');

%Hamming
window  = hamming(windowLength);
plot_time_domain(window, 7, 'Hamming Window');

%Blackman-Harris 4
window  = blackmanharris(windowLength);
plot_time_domain(window, 8, 'Blackman-Harris Window');
