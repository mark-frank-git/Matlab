function coded_output = encode_rate_on_half(bits)
% **********************************************************************
% function encode_rate_on_half(y)
%
% Encodes a set of bits using the rate 1/2 convolutional coder for GSM
%
% Description:
% -----------
% Rate 1/2 coder
%
% Input variables:
% -----------------------
%  bits        : vector of bits
%
% Output variables:
% -----------------------   
%  coded_output : encoded bits
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
%
% Revision History
% ----------------
%  - Dec. 20, 2012 - Started
% *************************************************************************
%
% Set up the trellis, constraint length = 5, polynomials = 23 and 33 octal
%
trellis         = poly2trellis([5],[23 33]);
coded_output    = convenc(bits, trellis);
return;
