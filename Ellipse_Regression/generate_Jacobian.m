function [J] = generate_Jacobian(x, y, circle_params)
% **********************************************************************
% function generate_Jacobian(x, y, circle_params)
%
% Generate Jacobian matrix for circle regression using Newton Raphson
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
% Notations:
% ----------
%
% Calls:
% -----------
%  None
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
J(1,1)              = (x(1)-a)/sqrt((x(1)-a)^2+(y(1)-b)^2);
J(1,2)              = (y(1)-b)/sqrt((x(1)-a)^2+(y(1)-b)^2);
J(1,3)              = 1;

J(2,1)              = (x(2)-a)/sqrt((x(2)-a)^2+(y(2)-b)^2);
J(2,2)              = (y(2)-b)/sqrt((x(2)-a)^2+(y(2)-b)^2);
J(2,3)              = 1;

J(3,1)              = (x(3)-a)/sqrt((x(3)-a)^2+(y(3)-b)^2);
J(3,2)              = (y(3)-b)/sqrt((x(3)-a)^2+(y(3)-b)^2);
J(3,3)              = 1;
return;
