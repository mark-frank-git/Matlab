function  conical_scan()
%
% function conical_scan()
%
% Problem 16 in GNC005A
%
% Description:
% ------------
%  Plots the conical scan
%
% Input variables:
% ----------------
%  None
%
% Output variables:
% -----------------
%  none
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
NUMBER_POINTS	= 100;
THETA			= 15*pi/180.;
%
% Generate uy spaced in [-1, 1]
%
uy			= linspace(-1, 1, NUMBER_POINTS);
%
% Find the discriminant of the quadratic, and consider those points
% where disc > 0
%
b			= sqrt(3)*cos(THETA) - uy;
c			= uy.*uy - sqrt(3)*cos(THETA)*uy + 1.5*cos(THETA)*cos(THETA) - .5;
disc		= b.*b - 4*c;
index		= find(disc>0);
%
% Solve for uz
%
uz_pos		= (-b(index) + sqrt(disc(index)))/2;
uz_neg		= (-b(index) - sqrt(disc(index)))/2;

uz			= [uz_pos uz_neg];

uy_new		= [uy(index) uy(index)];

ux			= uz + sqrt(3)*cos(THETA) - uy_new;

%
% 
%
theta		= asin(-uz);
psi			= asin(uy_new./cos(theta));

theta		= 180*theta/pi;
psi			= 180*psi/pi;
%
% 
%
theta_d		= asin(1/sqrt(3));
psi_d		= asin(1/sqrt(3)/cos(theta_d));

theta_d		= 180*theta_d/pi
psi_d		= 180*psi_d/pi


figure(1), clf, hold off
plot(theta)
grid on
title ('Elevation Angle');
ylabel('theta in degrees');

figure(2), clf, hold off
plot(psi)
grid on
title ('Azimuth Angle');
ylabel('psi in degrees');

