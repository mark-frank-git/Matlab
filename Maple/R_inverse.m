function  R_inv = R_inverse()
%
% function  a_corr = autocorr_perfect_4(code)
%
% autocorr_perfect_4 returns the autocorrelation from the perfect code.
%
% Description:
% ------------
%  Returns the autocorrelation from the perfect code
%
% Input variables:
% ----------------
%  code:			: code or shifted version of the code
%
% Output variables:
% -----------------
%  auto_corr		: autocorrelation column vector
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%  Al Samuels.
%
% Revision History
% ----------------
%  - April 20, 2005 - Started.
% *****************************************************************************
%
syms R11 R12 R13 R12H R22 R23 R13H R23H	R33 D
%
% Generate the autocorrelation matrix
%
R			= [R11 R12 R13; R12H R22 R23; R13H R23H R33];
%
% Find inverse
%
R_inv1		= inv(R);
%
% Substitute for the Determinant
%
D			= det(R);
R_inv1		= subs(R_inv1, D, 'D');
%
% make subsitutions to reduce
%
R12_sq	= 'R12H*R12';
R23_sq	= 'R23H*R23';
R13_sq	= 'R13H*R13';
R_inv2	= subs(R_inv1,R12_sq,'R12^2',0);
R_inv3	= subs(R_inv2,R23_sq,'R23^2',0);
R_inv	= subs(R_inv3,R13_sq,'R13^2',0);
%
% Do the commutative operations:
%
clear R12_sq R23_sq R13_sq
R12_sq	= 'R12*R12H';
R23_sq	= 'R23*R23H';
R13_sq	= 'R13*R13H';
R_inv1	= subs(R_inv,R12_sq,'R12^2',0);
R_inv2	= subs(R_inv1,R23_sq,'R23^2',0);
R_inv	= subs(R_inv2,R13_sq,'R13^2',0);



%
% >> r_inv = R_inverse()
 
% r_inv =
 
% [      (R22*R33-(R23^2))/D,    -(R12*R33-R13*R23H)/D,      (R12*R23-R13*R22)/D]
% [   (-R12H*R33+R23*R13H)/D,      (R11*R33-(R13^2))/D,    -(R11*R23-R13*R12H)/D]
% [ -(-R12H*R23H+R22*R13H)/D,   -(R11*R23H-R12*R13H)/D,      (R11*R22-(R12^2))/D]
 

