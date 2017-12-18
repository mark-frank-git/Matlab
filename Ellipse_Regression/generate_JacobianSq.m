function [J] = generate_JacobianSq(x, y, circle_params)
% **********************************************************************
% function generate_JacobianSq(x, y, circle_params)
%
% Generate Jacobian matrix for circle regression using Newton Raphson
% circle equation: r^2 = (x-a)^2 + (y-b)^2
%
% Description:
% -----------
% Generate Jacobian
%
% Input variables:
% -----------------------
%  x                : 3 x-points on circle
%  y                : 3 y-points on circle
%  circle_params    : [a b r] : (a,b) = circle center, r = radius
%
% Output variables:
% -----------------------
%  J                : 3 x 3 Jacobian
%
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
J                   = zeros(kNUMBER_UNKNOWNS);
%
% get circle parameters
%
a                   = circle_params(1);
b                   = circle_params(2);
r                   = circle_params(3);
%
% Fill in the Jacobian
%
J(1,1)              = 2*(x(1)-a);
J(1,2)              = 2*(y(1)-b);
J(1,3)              = 2*r;

J(2,1)              = 2*(x(2)-a);
J(2,2)              = 2*(y(2)-b);
J(2,3)              = 2*r;

J(3,1)              = 2*(x(3)-a);
J(3,2)              = 2*(y(3)-b);
J(3,3)              = 2*r;

return;
