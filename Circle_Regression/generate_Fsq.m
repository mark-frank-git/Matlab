function [F] = generate_Fsq(x, y, circle_params)
% **********************************************************************
% function generate_Fsq(x, y, circle_params)
%
% Generate F vector for circle regression using Newton Raphson
% circle equation: r^2 = (x-a)^2 + (y-b)^2
%
% Description:
% -----------
% Generate F
%
% Input variables:
% -----------------------
%  x                : 3 x-points on circle
%  y                : 3 y-points on circle
%  circle_params    : [a b r] : (a,b) = circle center, r = radius
%
% Output variables:
% -----------------------
%  F                : 3 x 1 F vector
%
% References:
% -----------
% Newton Raphson solution of non-linear equations
%
% Revision History
% ----------------
%  - Jan. 8, 2013 - Started
% *************************************************************************
%
% Initialize matrix
%
kNUMBER_UNKNOWNS    = 3;
F                   = zeros(kNUMBER_UNKNOWNS, 1);
%
% get circle parameters
%
a                   = circle_params(1);
b                   = circle_params(2);
r                   = circle_params(3);
%
% Fill in the F matrix
%
F(1)                = r*r - (x(1) - a)^2 - (y(1) - b)^2;
F(2)                = r*r - (x(2) - a)^2 - (y(2) - b)^2;
F(3)                = r*r - (x(3) - a)^2 - (y(3) - b)^2;

return;
