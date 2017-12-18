function alpha = generate_alpha(y)
% **********************************************************************
% function generate_alpha(y)
%
% Generates alpha for linear regression, such that y = alpha + x*beta
%
% Description:
% -----------
% Linear regression alpha
%
% Input variables:
% -----------------------
%  y           : vector of y values
%
% Output variables:
% -----------------------
%  alpha
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
% Clay S. Turner: Slope FIltering: An FIR Approach to Linear Regression
%
% Revision History
% ----------------
%  - Oct. 26, 2010 - Started
% *************************************************************************
%
% Generate xs
%
size    = length(y);
x       = 0:size-1;
%
% Find the terms
%
sum_y   = sum(y)
sum_x2  = sum(x.*x)
sum_x   = sum(x)
sum_xy  = sum(x.*y)
%
% calculate alpha
%
alpha   = (sum_y*sum_x2 - sum_x*sum_xy)
alpha   = alpha/(size*sum_x2-sum_x*sum_x)
return;
