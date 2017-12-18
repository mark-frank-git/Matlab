function  a_corr = autocorr_perfect_4(code)
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
syms a b c d ac bc cc dc a_sq b_sq c_sq d_sq
%
% Generate the autocorrelation matrix
% Note that ac = conj(a)
%
auto_mat	= [0 0 0 ac; 0 0 ac bc; 0 ac bc cc; ac bc cc dc; bc cc dc 0; cc dc 0 0; dc 0 0 0];
a_corr		= auto_mat * code;
%
% make subsitutions to reduce
%
a_sq	= ac*a;
b_sq	= bc*b;
c_sq	= cc*c;
d_sq	= dc*d;
b_corr	= subs(a_corr,a_sq,'a^2');
a_corr	= subs(b_corr,b_sq,'b^2');
b_corr	= subs(a_corr,c_sq,'c^2');
a_corr	= subs(b_corr,d_sq,'d^2');
%
