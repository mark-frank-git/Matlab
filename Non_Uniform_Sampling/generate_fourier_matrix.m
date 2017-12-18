function f_matrix = generate_fourier_matrix(times)
% **********************************************************************
% function generate_fourier_matrix(times)
%
% Generates a "Fourier" matrix at the non-uniform sampling times
%
% Description:
% -----------
% Generate Fourier matrix
%
% Input variables:
% -----------------------
%  times        : sample times
%
% Output variables:
% -----------------------
%  f_matrix     : Fourier matrix:
%                 row 1 = [e(-j*omega1*k)] k = 1...Number times
%                 row 2 = [e(-j*omega2*k)] k = 1...Number times
%
% Notes:
% ----------
% omegas are chosen such that the sine waves are orthogonal over the interval
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% None
%
% Revision History
% ----------------
%  - April 6, 2013 - Started
% *************************************************************************
%
%
% Initialize output matrix
%
f_matrix    = zeros(length(times), length(times));
%
% generate the rows
%
omega           = 2*pi/times(length(times));
for k=1:length(times)
  row           = exp(i*(k-1)*omega*times);
  f_matrix(k,:) = row;
end
return;
