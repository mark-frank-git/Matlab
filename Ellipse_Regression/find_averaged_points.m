function [x_pts, y_pts] = find_averaged_points(thresholds, iq_angles, iq_data)
% **********************************************************************
% function find_averaged_points(thresholds, iq_data)
%
% Finds averaged points for an 8-PSK signal
%
% Description:
% -----------
% Finds the 8 averaged points for an 8-PSK signal
%
% Input variables:
% -----------------------
%  thresholds       : phase thresholds in radians
%  iq_angles        : Angles of IQ data in radians
%  iq_data          : IQ points corresponding to angles
%
% Output variables:
% -----------------------
%  x_pts            : 8 x values
%  y_pts            : 8 y values
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
% None
%
% Revision History
% ----------------
%  - Jan. 15, 2013 - Started
% *************************************************************************
%
% Find the indices of angles between thresholds
%
numberThresholds    = length(thresholds);
x_pts               = 1:numberThresholds;
y_pts               = 1:numberThresholds;
for i=1:numberThresholds-1
  index             = find_between_indices(iq_angles, thresholds(i), thresholds(i+1));
  x_pts(i)          = mean(real(iq_data(index)));
  y_pts(i)          = mean(imag(iq_data(index)));
end
%
% Do the last point
%
index                   = find_or_indices(iq_angles, thresholds(8), thresholds(1));
x_pts(numberThresholds) = mean(real(iq_data(index)));
y_pts(numberThresholds) = mean(imag(iq_data(index)));
return;


function [indices] = find_between_indices(x, xmin, xmax)
% **********************************************************************
% function find_between_indices(x, xmin, xmax)
%
% Finds the indices of all elements of x between xmin and xmax
%
% Description:
% -----------
% find between index
%
% Input variables:
% -----------------------
%  x                : array of values
%  xmin             : lower limit
%  xmax             : upper limit
%
% Output variables:
% -----------------------
%  indices          : indices such that xmin<x(indices)<xmax
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
% None
%
% Revision History
% ----------------
%  - Jan. 15, 2013 - Started
% *************************************************************************
k                   = 1;
for i=1:length(x)
  if(x(i)>xmin && x(i)<xmax)
    indices(k)      = i;
    k               = k+1;
  end
end
return

function [indices] = find_or_indices(x, xmin, xmax)
% **********************************************************************
% function find_between_indices(x, xmin, xmax)
%
% Finds the indices of all elements of x between xmin and xmax
%
% Description:
% -----------
% find between index
%
% Input variables:
% -----------------------
%  x                : array of values
%  xmin             : lower limit
%  xmax             : upper limit
%
% Output variables:
% -----------------------
%  indices          : indices such that xmin<x(indices)<xmax
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
% None
%
% Revision History
% ----------------
%  - Jan. 15, 2013 - Started
% *************************************************************************
k                   = 1;
for i=1:length(x)
  if(x(i)>xmin || x(i)<xmax)
    indices(k)      = i;
    k               = k+1;
  end
end
return
