function  a_corr = auto_corr_motion()
%
% function  a_corr = auto_corr_motion()
%
% auto_corr_motion returns the autocorrelation for a moving jammer
%
% Description:
% ------------
%  Returns the autocorrelation for the moving jammer
%
% Input variables:
% ----------------
%  None
%
% Output variables:
% -----------------
%  auto_corr		: autocorrelation matrix
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
syms g11 g12 g13 g21 g22 g23 g31 g32 g33 x1 x2 x3 g1x g2x g3x x
syms dg1 dg2 dg3 dg4 g41 g4x
%
% Generate the autocorrelation matrix
% Note that ac = conj(a)
%
g1x			= [g11 g11+dg1 g11+dg1+dg1];
g2x			= [g21 g21+dg2 g21+dg2+dg2];
g3x			= [g31 g31+dg3 g31+dg3+dg3];
g4x			= [g41 g41+dg4 g41+dg4+dg4];
x			= [g1x; g2x; g3x; g4x];

x_corr		= x*x.';
x_corr		= expand(x_corr);
%
% make subsitutions to reduce
%
x1_corr	= subs(x_corr,'dg1^2',0);
x2_corr	= subs(x1_corr,'dg2^2',0);
x3_corr	= subs(x2_corr,'dg3^2',0);
x4_corr	= subs(x3_corr,'dg1*dg2',0);
x5_corr	= subs(x4_corr,'dg1*dg3',0);
a_corr	= subs(x5_corr,'dg2*dg3',0);
a_corr	= x_corr;