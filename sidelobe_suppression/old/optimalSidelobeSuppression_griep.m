function  [filterFn, islDB, snrLoss] = optimalSidelobeSuppression(polyphaseCode, weightingVector, filterLength)
%
% function  [filterFn isl snrLoss] =
% optimalSidelobeSuppression(polyphaseCode, weightingVector, filterLength)
%
% optimalSidelobeSuppression calculates the mismatched filter having the lowest
% integrated side lobe level.
%
% Description:
%  Calculates mismatched filter
%
% Input variables:
% ----------------
%  polyphaseCode:	A polyphase code (row vector) whose elements are given
%    as complex numbers
%  weightingVector: A weighting row vector for calculating the filter.  Values
%    of 1 are given high weighting, values near zero are given low weighting.
%    Values in the middle of the array correspond to close in sidelobe.  The
%    very center element should have a value of 0.  The length of
%    weightingVector should be filterLength + filterLength - 1
%  filterLength:    Length of the output filter
%
% Output variables:
% ----------------
%  filterFn:		The mismatched filter as a row vector given in phase
%     radians
%  islDB:			The integrated sidelobe level in dB relative to the peak.
%  snrLoss:			SNR loss in dB relative to the matched filter.
%
%--------
% Notations:
%
% Known Bugs:
%
% References:
%  [LEV04]: Levanon, N. and Mozeson, E. Radar Signals, John Wiley & Sons, 2004.
%  [GRI95]: Griep, K.R., Ritcey, J.A., Burlingame, J.J., "Polyphase codes
%  and optimal filters for multiple user ranging," IEEE Trans Aero, April
%  1995.
%
% Revision History
%  - April 4, 2005 - Started.
% *****************************************************************************
%
% Get the signal vector from the code vector:
%
s					= polyphaseCode;
s_dot				= s*s';
code_length			= length(polyphaseCode);
filterLength		= max(code_length, filterLength);
p					= filterLength;
%
% Generate the X matrix
%
s_padded			= [s zeros(1, filterLength-code_length)];
shift_val			= round((filterLength-code_length)/2);
s_padded			= circshift(s_padded', shift_val)';
s_row				= [zeros(1,p-1) s_padded];
for				row = 1:p
	X( [row], :)	= s_row;
	s_row			= circshift(s_row', -1)';
end
size(X);
X;
%
% Generate F matrix from weight vector
%
F					= diag(weightingVector, 0);
size(F);
%
% Generate B matrix from F and lambda
%
B					= X*F*X';
B_inv				= inv(B);

%
% Generate filter function
%
x					= s_padded.';
filterFn			= code_length*B_inv*x/(x'*B*x);
%
% Calculate final isl, and normalize to peak value
%
signal_mismatched	= xcorr(filterFn, s);

%
%
% Plot cross correlation
%
figure(filterLength), clf, hold off
plot_array			= abs(signal_mismatched);
plot(plot_array);
%
%
max_mismatched		= max(signal_mismatched);
%
% Calculate SNR loss
%
h_dot				= filterFn*filterFn';
islDB	= 0;
snrLoss	= 0;
