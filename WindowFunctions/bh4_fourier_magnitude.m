function magnitude = bh4_fourier_magnitude(omegas, windowLength)
% **********************************************************************
% function magnitude = bh4_fourier_magnitude(omegas, windowLength)
%
% Returns the magnitudes of the Fourier transform of the blackman-harris 4 window at the input frequencies
%
% Description:
% -----------
% Fourier transform of bh4 window
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
number_coeffs    = 4;
blackman4_coeffs = [0.35875 -0.48829 0.14128 -0.01168];
dftPoints        = length(omegas);
for k=1:dftPoints
  blackman_sum   = 0.;
  for m=1:number_coeffs
    m_minus1      = m-1;
    arg1          = dirichlet_kernel(omegas(k)-2.*pi*m_minus1/windowLength, windowLength);
    arg2          = dirichlet_kernel(omegas(k)+2.*pi*m_minus1/windowLength, windowLength);
    blackman_sum  = blackman_sum + blackman4_coeffs(m)*(arg1 + arg2)/2.;
  end
  magnitude(k)    = blackman_sum*conj(blackman_sum);
end

return;
