function  [filterFn, relResidual] = optimalSidelobeSuppressionLS(s, ...
										filterLength, b, xStart, figureNumber)
%
% function  [filterFn, relResidual] = optimalSidelobeSuppressionLS(s, ...
%										filterLength, b, figureNumber)
%
% optimalSidelobeSuppressionLS calculates the mismatched filter having the lowest
% integrated side lobe level.
%
% Description:
%  Calculates mismatched filter
%
% Input variables:
% ----------------
%  s:				Code vector with complex elements.
%  filterLength:    Length of the output filter
%  b: 				Desired output
%  xStart:          Starting guess for LSQR algorithm
%  figureNumber:	If 0, don't plot
%
% Output variables:
% ----------------
%  filterFn:		The mismatched filter as a row vector given in phase
%                   radians
%  relResidual:		Relative residual of lsqr().
%
% Notations:
% --------
%
% Calls:
% --------
% generateLambdaLS	: For generating the Lambda matrix
% calcISLdB			: For calculating ISL in dB
% polyphase_code	: For generating the code given code type
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
%  - June 1, 2005 - Add SOLUTION_TYPE
% *************************************************************************
LEAST_SQUARES_SOLN		= 1;
SVD_SOLN				= 2;
INVERSE_SOLN			= 3;
SOLUTION_TYPE			= SVD_SOLN;

TOL						= 1e-20;
%
% Get the parameters of the code and filter:
%
code_length			= length(s);
s_dot				= s*s';
filterLength		= max(code_length, filterLength);
p					= filterLength;
%
% Generate the lambda matrix
%
lambda				= generateLambdaLS(s, code_length, filterLength);
size(lambda);
lambda;
b_length			= filterLength+code_length-1;
[filterFn,flag, relResidual]			= lsqr(lambda, b, TOL, [], [], [], xStart);
filterFn			= filterFn.';
%
% Normalize filter and code:
%
%filterFn			= filterFn/sqrt(filterFn*filterFn');
s					= s/sqrt(s_dot);
%
% Calculate cross correlation for plotting, and ISL
%
signal_mismatched	= xcorr(filterFn, s);
signal_mismatched;
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
condA				= 1;

