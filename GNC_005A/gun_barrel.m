function [R01 omega_1 centripetal transverse] = gun_barrel()
%
% function  [R01 omega_1 centripetal transverse] = gun_barrel()
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
syms cos_psi sin_psi cos_theta sin_theta
syms psi_dot theta_dot el
%
% Generate the autocorrelation matrix
% Note that ac = conj(a)
%
R_PSI		= [cos_psi -sin_psi 0; sin_psi cos_psi 0; 0 0 1];
R_THETA		= [cos_theta 0 sin_theta; 0 1 0; -sin_theta 0 cos_theta];

R01			= R_PSI*R_THETA;
R10			= R01.';
omega_0		= [-theta_dot*sin_psi theta_dot*cos_psi psi_dot].';
omega_1		= R10*omega_0;
%
% Find the angular acceleration terms
%
p_10		= R01 * [el; 0; 0;];
centripetal	= cross(omega_0, p_10);
centripetal = cross(omega_0, centripetal);

ang_accel	= [-theta_dot*psi_dot*cos_psi; -theta_dot*psi_dot*sin_psi; 0];
transverse	= cross(p_10, ang_accel);
