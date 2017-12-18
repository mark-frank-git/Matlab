function y = overlap_and_save(x, h, L)
% **********************************************************************
% function overlap_and_save(x, h, L)
%
% Use overlap and save to filter the vector x
%
% Description:
% -----------
% Overlap and save filtering
%
% Input variables:
% -----------------------
%  x	= input vector
%  h	= filter coefficients
%  L	= FFT length
%
% Output variables:
% -----------------------
%  y	= filtered signal
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
% Overlap and Save
%
% Revision History
% ----------------
%  - Sept. 23, 2011, started
% *************************************************************************

h = h(:);
x = x(:);					% make sure x and h are column vectors
P = length(h);
N = length(x);
D = L-P+1;
x = [zeros(P-1,1);x];		% zero pad front end of x for first window

H = fft(h,L);				% Zero pad h to L points, and fft.
y = [];

for r = 0:fix(N/D)-1
    xr = x(r*D+1:r*D+L);	% extract overlapping r_th window from x
    Xr = fft(xr);	
    Yrp = Xr .* H;			% Multiply in frequency domain
    yrp = ifft(Yrp);
    y = [y; yrp(P:L)];		% Concatenate good points from each window
end
