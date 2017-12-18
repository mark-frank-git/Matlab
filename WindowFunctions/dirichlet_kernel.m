function kernel = dirichlet_kernel(omega, length)
% **********************************************************************
% function kernel = dirichlet_kernel(omega, length)
%
% Returns the kernel of the Dirichlet kernel at the given digital frequency
%
% Description:
% -----------
% Dirichlet kernel (can be used to find the Fourier transform of some of the window functions)
%
% Input variables:
% -----------------------
%  omega        : digital frequency [-PI, PI]
%  length       : length of window
%
% Output variables:
% -----------------------
%  kernel    : kernel of DFT at omega
%
%
% Revision History
% ----------------
%  - August 4, 2017 - Started
% *************************************************************************
%
if(omega == 0.)
  kernel = length + i*0.;
elseif ( (omega<(-pi) || (omega>(pi))))
  kernel = 0. + i*0.;
else
  sin_omega_2 = sin(omega/2.);
  if(sin_omega_2 ~= 0.)
    carg	  = 0. - i*omega*(length-1)/2.;
    kernel  = exp(carg)*sin(length*omega/2.)/sin_omega_2;
  else
    kernel = 1. + i*0.
  end
end

return;