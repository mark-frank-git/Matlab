function magnitude = hamming_fourier_magnitude(omegas, windowLength)
% **********************************************************************
% function magnitude = hamming_fourier_magnitude(omegas, windowLength)
%
% Returns the magnitudes of the Fourier transform of the hamming window at the input frequencies
%
% Description:
% -----------
% Fourier transform of hamming window
%
% Input variables:
% -----------------------
%  omegas       : digital frequencies [-PI, PI]
%  windowLength : length of window
%
% Output variables:
% -----------------------
%  magnitude    : Magnitudes of DFT at omegas
%
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
dftPoints     = length(omegas);
for i=1:dftPoints
  magnitude(i)      = 0.54*  dirichlet_magnitude(omegas(i), windowLength) + ...
                      0.5*(1.-0.54)* (dirichlet_magnitude(omegas(i)- 2.*pi/windowLength, windowLength) + ...
                                      dirichlet_magnitude(omegas(i)+ 2.*pi/windowLength, windowLength));
  magnitude(i)      = magnitude(i)*magnitude(i);
end

return;
