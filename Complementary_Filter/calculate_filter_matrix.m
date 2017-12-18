function  [filterMatrix] = calculate_filter_matrix(filterCoeffs)
%
% function  [filterMatrix] = calculate_filter_matrix(filterCoeffs)
%
% Returns the filter matrix from the coefficients
%
% Description:
% ------------
%  Returns the filter matrix
%
% Input variables:
% ----------------
%  filterCoeffs		: input filter taps
%
% Output variables:
% -----------------
%  filterMatrix		: output filter matrix = 
%                       [in_taps(1)            0 ... 0 0
%                        in_taps(2) in_taps(1) 0 ... 0 0
%                        0                     0       in_taps(n)]
%
% Calls:
% -----------------
%  None
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%
% Revision History
% ----------------
%  - Aug 7, 2009 - Started.
% *****************************************************************************
%
% Constants:
%
n		= length(filterCoeffs);
filterMatrix	= zeros(n, n);
reverse_index	= linspace(n,1,n);
filter_reverse	= filterCoeffs(reverse_index);
filter_padded	= [filter_reverse zeros(1, n-1)];
filter_index	= linspace(n,2*n-1,n);
%
% Now, loop over the rows
%
for row=1:2*n-1
  filterMatrix([row],:)	= filter_padded(filter_index);
  filter_padded		= circshift(filter_padded', 1)';
end
return;