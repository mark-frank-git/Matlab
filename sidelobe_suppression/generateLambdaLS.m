function  lambda = generateLambdaLS(s, codeLength, filterLength)
%
% function  lambda = generateLambdaLS(s, codeLength, filterLength)
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
%        sn 0 ...             0
%        sn-1 sn ...            0
%        ...
%        s0 s1 .... sn 0  0 0
%         0 s0  s1 ...s0 0 0
%         ...
%         0 ...             0 s0
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
s_padded			= [s ];
rev_index			= codeLength:-1:1;
s_reverse			= s_padded(rev_index);
s_row				= [s_reverse zeros(1, p-1)];
for	row				= 1:p
	lambda( [row], :)	= s_row;
	s_row			= circshift(s_row', 1)';
end
%
% Take the transpose
%
lambda				= lambda.';
