function  block_matrix = block_matrices()
%
% Forms a block matrix
%
%
% Description:
% ------------
%  Returns the autocorrelation from the perfect code
%
% Input variables:
% ----------------
%  None
%
% Output variables:
% -----------------
%  block matrix
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%  Al Samuel.
%
% Revision History
% ----------------
%  - Sept 15, 2005 - Started.
% *****************************************************************************
%
syms a b c d e f g h b1 b2 block_matrix
%
% Generate the autocorrelation matrix
% Note that ac = conj(a)
%
b1			= [a b; c d;]
b2			= [e f; g h;]
block_matrix	= [b1 b2; b2 b1;]

Output:
b1 =
 
[ a, b]
[ c, d]
 
 
 
b2 =
 
[ e, f]
[ g, h]
 
 
 
block_matrix =
 
[ a, b, e, f]
[ c, d, g, h]
[ e, f, a, b]
[ g, h, c, d]
 
 
 
block_matrix =
 
[ a, b, e, f]
[ c, d, g, h]
[ e, f, a, b]
[ g, h, c, d]
 