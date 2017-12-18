function [betas] = generate_betas(length)
% **********************************************************************
% function generate_betas(length)
%
% Generates betas for linear regression
%
% Description:
% -----------
% Linear regression betas
%
% Input variables:
% -----------------------
%  length           : Length of data
%
% Output variables:
% -----------------------
%  betas[i]
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
x   = 0:length-1;
%
% Plot the results
%
sum_x   = sum(x);
sum_x2  = sum(x.*x);
betas   = (length*x - sum_x)/(length*sum_x2 - sum_x*sum_x);

return;
