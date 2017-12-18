function R01 = ecef_to_local_transform()
%
% function  R01 = ecef_to_local_transform()
%
% Problem 10 in GNC005A
%
% Description:
% ------------
%  Returns the transformation from frame 1 to frame 0
%
% Input variables:
% ----------------
%  None
%
% Output variables:
% -----------------
%  R01			: Transformation matrix
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%  GNC 005A Notes
%
% Revision History
% ----------------
%  - Nov 10, 2006 - Started.
% *****************************************************************************
%
syms cos_psi sin_psi cos_alpha sin_alpha
%
% Generate the autocorrelation matrix
% Note that ac = conj(a)
%
R0A			= [cos_psi -sin_psi 0; sin_psi cos_psi 0; 0 0 1];
RAB			= [cos_alpha 0 -sin_alpha; 0 1 0; sin_alpha 0 cos_alpha];
RB1			= [-1 0 0; 0 1 0; 0 0 -1];

R01			= R0A*RAB*RB1;