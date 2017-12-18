function magnitude = hanning_fourier_magnitude(omegas, windowLength)
% **********************************************************************
% function magnitude = hanning_fourier_magnitude(omegas, windowLength)
%
% Returns the magnitudes of the Fourier transform of the Hanning window at the input frequencies
%
% Description:
% -----------
% Fourier transform of Hanning window
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
  magnitude(i)      = 0.5 *  dirichlet_magnitude(omegas(i), windowLength) + ...
                      0.25* (dirichlet_magnitude(omegas(i)- 2.*pi/windowLength, windowLength) + ...
                             dirichlet_magnitude(omegas(i)+ 2.*pi/windowLength, windowLength));
  magnitude(i)      = magnitude(i)*magnitude(i);
end

return;
