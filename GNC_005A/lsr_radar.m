function [lsr] = lsr_radar()
%
% function  lsr = lsr_radar()
%
% Problem 13 in GNC005A
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
%  lsr			: line-of-sight rate
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
syms psi_dot theta_dot
%
%
u_I			= [cos_psi*cos_theta; sin_psi*cos_theta; -sin_theta];
u_I_dot		= [-psi_dot*sin_psi*cos_theta-theta_dot*cos_psi*sin_theta; ...
               psi_dot*cos_psi*cos_theta-theta_dot*sin_psi*sin_theta;
               -theta_dot*cos_theta];

lsr			= cross(u_I, u_I_dot);
