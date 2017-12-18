function magnitude = dirichlet_magnitude(omega, length)
% **********************************************************************
% function magnitude = dirichlet_magnitude(omega, length)
%
% Returns the magnitude of the Dirichlet kernel at the given digital frequency
%
% Description:
% -----------
% Dirichlet magnitude (can be used to find the Fourier transform of some of the window functions)
%
% Input variables:
% -----------------------
%  omega        : digital frequency [-PI, PI]
%  length       : length of window
%
% Output variables:
% -----------------------
%  magnitude    : Magnitude of DFT at omega
%
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
if(omega == 0.)
  magnitude = length;
elseif ( (omega<(-pi) || (omega>(pi))))
  magnitude = 0.;
else
  sin_omega_2 = sin(omega/2.);
  if(sin_omega_2 ~= 0.)
    magnitude = sin(length*omega/2.)/sin_omega_2;
  else
    magnitude = 1.;
  end
end

return;
