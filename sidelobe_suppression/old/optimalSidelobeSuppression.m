function  [filterFn, islDB, snrLoss condA] = optimalSidelobeSuppression(codeType, codeLength, weightingType, ...
										filterLength, figureNumber)
%
% function  [filterFn isl snrLoss] =
% optimalSidelobeSuppression(polyphaseCode, weightingType, filterLength, figureNumber)
%
% optimalSidelobeSuppression calculates the mismatched filter having the lowest
% integrated side lobe level.
%
% Description:
%  Calculates mismatched filter
%
% Input variables:
% ----------------
%  codeType:		The code type, see polyphase_code
%  codeLength:		The length of the code
%  weightingType:	Type of weighting to apply, see below.
%  filterLength:    Length of the output filter
%  figureNumber:	If 0, don't plot
%
% Output variables:
% ----------------
%  filterFn:		The mismatched filter as a row vector given in phase
%                   radians
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
%  - April 6, 2005 - Take weightingType rather than weighting vector
% *****************************************************************************
USE_LEAST_SQUARES		= 1;
SAMPLES_PER_BIT			= 1;
%
% Specify the weighting types:
%
NARROW_MAIN_LOBE		= 1;			% 1 1 1 1 ... 1 0 1 ... 1 1 1
WIDE_MAIN_LOBE			= 2;			% 1 1 1 1 ... 1 0 0 0 1 ... 1 1 1
EXPONENTIAL_LOBE		= 3;			% exponential decay

MAX_EXP					= -4;			% decay to exp(-4)
%
% Calculate the weighting vector
%
switch weightingType
	case NARROW_MAIN_LOBE
			weight_vector					= ones(1, 2*filterLength-1);
			weight_vector(filterLength)		= 0;
	case WIDE_MAIN_LOBE
			weight_vector					= ones(1, 2*filterLength-1);
			weight_vector(filterLength)		= 0;
			weight_vector(filterLength+1)	= 0;
			weight_vector(filterLength-1)	= 0;
	otherwise									% exponential
			right_side						= 0:filterLength-2;
			right_side						= MAX_EXP*right_side/(filterLength-2);
			right_side						= exp(right_side);
			left_side						= filterLength-2:-1:0;
			left_side						= MAX_EXP*left_side/(filterLength-2);
			left_side						= exp(left_side);
			weight_vector					= [left_side 0 right_side];
end

%
% Get the signal vector from the code vector in radians:
%
s					= exp(i*polyphase_code(codeType, codeLength, SAMPLES_PER_BIT));
s_dot				= s*s';
filterLength		= max(codeLength, filterLength);
p					= filterLength;
%
% Generate the lambda matrix
%
s_padded			= [s zeros(1, filterLength-codeLength)];
shift_val			= round((filterLength-codeLength)/2);
shift_val			= shift_val;
if (shift_val>0)
	s_padded		= circshift(s_padded', shift_val)';
end
rev_index			= filterLength:-1:1;
s_reverse			= s_padded(rev_index);
s_row				= [s_reverse zeros(1, p-1)];
for	row				= 1:p
	lambda( [row], :)	= s_row;
	s_row			= circshift(s_row', 1)';
end
%
% Generate F matrix from weight vector
%
F					= diag(weight_vector, 0);
%
% Generate A matrix from F and lambda
%
A					= lambda*F*lambda';
condA				= cond(A);

%
% Generate first part of weighted energy:
%
if (USE_LEAST_SQUARES)
	x				= A\s_padded.';
	energy			= s_dot/(s_padded*x);
else
	A_inv			= inv(A);
	energy			= s_dot/(s_padded*A_inv*s_padded');
end
%
% Generate filter function
%
if (USE_LEAST_SQUARES)
	filterFn		= energy*x;
	filterFn		= filterFn.';
else
	filterFn		= s_padded*A_inv'*energy;
	filterFn		= conj(filterFn);
end
%
% Normalize filter and code:
%
filterFn			= filterFn/sqrt(filterFn*filterFn');
s					= s/sqrt(s_dot);
%
% Calculate cross correlation for plotting, and ISL
%
signal_mismatched	= xcorr(filterFn, s);
max_mis				= max(abs(signal_mismatched));
%
%
% Plot cross correlation
%
if(figureNumber > 0)
	figure(figureNumber), clf, hold off
	plot_array		= abs(signal_mismatched);
	save('C:\Data\Radar\mismatched\xcorr.dat','plot_array','-ASCII');
	plot(plot_array);
end
%
% Calculate energy and ISL as a dB value:
%
energy				= energy*s_dot;
islDB				= calcISLdB(signal_mismatched);
%
% Calculate SNR loss, as a positive value, note that
% s_dot and filterFn_dot have been normalized to 1.
%
snrLoss				= 10.*log10(1/max_mis/max_mis);

