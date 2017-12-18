function  [filterFn, islDB, snrLoss condA] = optimalSidelobeSuppressionDoppler(codeType, codeLength, weightingType, ...
										filterLength, doppler, figureNumber)
%
% function  [filterFn isl snrLoss] =
% optimalSidelobeSuppressionDoppler(codeType, codeLength, weightingType, filterLength, doppler, figureNumber)
%
% optimalSidelobeSuppressionDoppler calculates the mismatched filter having the lowest
% integrated side lobe level, at 0 and doppler frequencies.
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
%  doppler:			Doppler frequencies as fd*T (where T = code length) as
%                   row vector (include doppler = 0, if desired)
%  figureNumber:	If 0, don't plot
%
% Output variables:
% ----------------
%  filterFn:		The mismatched filter as a row vector given in phase
%                   radians
%  islDB:			The integrated sidelobe level in dB relative to the peak.
%  snrLoss:			SNR loss in dB relative to the matched filter.
%  condA:			Conditioning of A matrix
%
% Notations:
% --------
%
% Calls:
% --------
% generateLambda for generating the Lambda matrix
% calcISLdB for calculating the ISL level in dB
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
%  - June 1, 2005 - Add SCHUR_SOLN
% *****************************************************************************
LEAST_SQUARES_SOLN		= 1;
SVD_SOLN				= 2;
INVERSE_SOLN			= 3;
SOLUTION_TYPE			= SVD_SOLN;
SAMPLES_PER_BIT			= 1;

%
% Specify the weighting types:
%
NARROW_MAIN_LOBE		= 1;			% 1 1 1 1 ... 1 0 1 ... 1 1 1
WIDE_MAIN_LOBE			= 2;			% 1 1 1 1 ... 1 0 0 0 1 ... 1 1 1
EXPONENTIAL_LOBE		= 3;			% exponential decay

MAX_EXP					= -4;			% decay to exp(-4)
%
% Calculate the weighting vector, since we are trying to weight both the
% 0, and doppler frequency solutions, the weight vector gets doubled.
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
% Generate F matrix from weight vector, and extend it by length(doppler)
%
weight_vector_new	= weight_vector;
for k =	2:length(doppler)
  weight_vector_new	= [weight_vector_new weight_vector];
end
F					= diag(weight_vector_new, 0);
%
% Get the signal vector from the code vector in radians:
%
s					= exp(i*polyphase_code(codeType, codeLength, SAMPLES_PER_BIT));
s_dot				= s*s';
filterLength		= max(codeLength, filterLength);
p					= filterLength;
%
% Generate the lambda matrix for all doppler frequencies
%
for k = 1:length(doppler)
  omega				= 2*pi*doppler(k)*[0:(codeLength-1)]/codeLength;
  s_doppler			= exp(i*omega) .* s;
  lambda_new		= generateLambda(s_doppler, codeLength, filterLength);
  if(k==1)
	lambda			= lambda_new;
  else
    lambda			= [lambda lambda_new];			% Augment lambda matrix with new doppler
  end												% constraint
end
clear	lambda_new;
%
% Generate A matrix from F and lambda
%
A					= lambda*F*lambda';
condA				= cond(A);
clear	F;
clear	lambda;
%
% Generate first part of weighted energy:
%
switch SOLUTION_TYPE
	case LEAST_SQUARES_SOLN
	  x				= A\s_padded.';
	  energy		= s_dot/(s_padded*x);
	  filterFn		= energy*x;
	  filterFn		= filterFn.';
	case INVERSE_SOLN
	  A_inv			= inv(A);
	  energy		= s_dot/(s_padded*A_inv*s_padded');
	  filterFn		= s_padded*A_inv'*energy;
	  filterFn		= conj(filterFn);
    case SVD_SOLN
	  [U, T, V]		= svd(A);
      [m n]			= size(U);
	  filterFn		= U(:,n).';
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
% Calculate ISL as a dB value:
%
islDB				= calcISLdB(signal_mismatched);
%
% Calculate SNR loss, as a positive value, note that
% s_dot and filterFn_dot have been normalized to 1.
%
snrLoss				= 10.*log10(1/max_mis/max_mis);

