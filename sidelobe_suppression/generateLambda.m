function  lambda = generateLambda(s, codeLength, filterLength)
%
% function  lambda = generateLambda(s, codeLength, filterLength)
%
% generateLambda generates the lambda matrix given the code vector, code length, and
% filter length.
%
% Description:
%  Calculates lambda matrix
%
% Input variables:
% ----------------
%  s:				Code vector (could be doppler shifted)
%  codeLength:		The length of the code
%  filterLength:    Length of the output filter
%
% Output variables:
% ----------------
%  lambda:			The lambda matrix, which is composed of shifted
%                   versions of the code vector
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
%  - June 2, 2005 - Extracted from optimalSidelobeSuppression.
% *****************************************************************************
%
%
% Generate the lambda matrix for 0 frequency
%
p					= filterLength;
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
% Clear unused values:
%
clear	s_padded;
clear	rev_index;
clear	s_reverse;
clear	s_row;
