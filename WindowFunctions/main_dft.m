function  main_dft()
% **********************************************************************
% function main_dft()
%
% Main program for plotting the Fourier transform of window functions
%
% Description:
% -----------
% Main driver
%
% Input variables:
% -----------------------
%  None
%
% Output variables:
% -----------------------
%  None
%
% Calls:
% -----------
%  dirichlet_magnitude, hanning_fourier_magnitude, hamming_fourier_magnitude, bh4_fourier_magnitude
%  plot_dft
%
% References:
% -----------
% Harris' window paper
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
% Set up
%
windowLength  = 90;
dftPoints     = 500;
frequency     = linspace(-pi, pi, dftPoints);

% Rectangular
for i=1:dftPoints
  mag(i)      = dirichlet_magnitude(frequency(i), windowLength);
  mag(i)      = mag(i)*mag(i);
end
plot_dft(frequency, mag, 1, 'Rectangular FT');

%Hann
mag           = hanning_fourier_magnitude(frequency, windowLength);
plot_dft(frequency, mag, 2, 'Hann Window FT');

%Hamming
mag           = hamming_fourier_magnitude(frequency, windowLength);
plot_dft(frequency, mag, 3, 'Hamming Window FT');

%Blackman-Harris 4
mag           = bh4_fourier_magnitude(frequency, windowLength);
plot_dft(frequency, mag, 4, 'Blackman-Harris 4 Window FT');