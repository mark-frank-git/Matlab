function  [y] = overlap_and_save_test(fft_size)
%
% function  [y] = overlap_and_save_test(fft_size)
%
% Test overlap and save
%
% Description:
% ------------
%  Filter using overlap and save
%
% Input variables:
% ----------------
%  fft_size		: Size of FFT to use
%
% Output variables:
% -----------------
%  y			: Filtered signal
%
% Calls:
% -----------------
%  overlap_and_save
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%
% Revision History
% ----------------
%  - Sept 23, 2011 - Started.
% *****************************************************************************
%
% Constants:
%
%
% Load the filter coefficients.  These are at 4 x chip rate
%
load comp_filter.dat;
%
% Load the complex signal
%
x	= csvread('x.dat');
%
% Run the algorithm
%
y	= overlap_and_save(x, comp_filter, fft_size);
plot(real(y));

return;