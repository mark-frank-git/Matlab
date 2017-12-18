function  print_betas(betas, full_scale)
% **********************************************************************
% function print_betas(betas, full_scale)
%
% Print betas for linear regression
%
% Description:
% -----------
% Print linear regression betas
%
% Input variables:
% -----------------------
%  betas            : Betas to print
%  full_scale       : Full scale value, for example, 2147483647 for 32 bit integers
%
% Output variables:
% -----------------------
%  None
%
% Notations:
% ----------
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% Clay S. Turner: Slope FIltering: An FIR Approach to Linear Regression
%
% Revision History
% ----------------
%  - Oct. 26, 2010 - Started
% *************************************************************************
%
% Find max beta, and scale to full scale
%
max_beta        = max(abs(betas));
scale           = full_scale/max_beta
betas           = round(scale*betas);
linear_scale    = scale/full_scale
%
% Print betas to file
%
fid             = fopen('C:\Users\fran_mar\Matlab\Orion\Linear_Regression\betas.dat');
length_betas    = length(betas);
for i=1:length_betas
  fprintf('(Ipp32s)     %12.0f,\n', betas(i));
end
return;
