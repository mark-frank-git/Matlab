function [a] = fitCircle(x, y)
% **********************************************************************
% function fitCircle(x)
%
% Fits circle to x and y data
%
% Description:
% -----------
% Fit circle
%
% Input variables:
% -----------------------
%  x                : x points on circle
%  y                : y points on circle
%
% Output variables:
% -----------------------
%  a                : A, B, C: x^2 + y^2 = Ax + By + C
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% http://www.had2know.com/academics/best-fit-circle-least-squares.html
%
% Revision History
% ----------------
%  - Jan. 16, 2013 - Started
% *************************************************************************
%
% Initialize parameters
%
AMatrix             = zeros(3,3);
AMatrix(1,1)        = mean(x.^2);
AMatrix(1,2)        = mean(x.*y);
AMatrix(1,3)        = mean(x);
AMatrix(2,1)        = AMatrix(1,2);
AMatrix(2,2)        = mean(y.^2);
AMatrix(2,3)        = mean(y);
AMatrix(3,1)        = AMatrix(1,3);
AMatrix(3,2)        = AMatrix(2,3);
AMatrix(3,3)        = 1;
BMatrix             = zeros(3,1);
BMatrix(1)          = mean(x.*(x.*x + y.*y));
BMatrix(2)          = mean(y.*(x.*x + y.*y));
BMatrix(3)          = mean(x.*x + y.*y);
a                   = AMatrix\BMatrix;
AMatrix
BMatrix
return;