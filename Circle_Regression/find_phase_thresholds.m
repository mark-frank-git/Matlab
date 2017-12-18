function [thresholds] = find_phase_thresholds(iq_angles, numberThresholds)
% **********************************************************************
% function find_phase_thresholds(iq_angles)
%
% Finds phase thresholds for an 8-PSK signal
%
% Description:
% -----------
% Find phase thresholds for grouping the phases
%
% Input variables:
% -----------------------
%  iq_angles        : sorted array of angles on the circle
%  numberThresholds : e.g., 8 for 8-PSK
%
% Output variables:
% -----------------------
%  thresholds       : phase thresholds in radians
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
% Find the max gap between phases
%
k_PHASE_INTERVAL    = 2*pi/numberThresholds;
size                = length(iq_angles);
max_gap             = 0;
max_value           = 0;
for i=1:size-1
  gap               = iq_angles(i+1) - iq_angles(i);
  if(gap > max_gap)
    max_gap         = gap;
    max_value       = (iq_angles(i+1) + iq_angles(i))/2.;
  end;
end;
while max_value > -pi;
  max_value         = max_value - k_PHASE_INTERVAL;
end
if max_value < -pi;
  max_value         = max_value + k_PHASE_INTERVAL;
end
thresholds          = linspace(1,numberThresholds,numberThresholds);
for i=1:8
  thresholds(i)     = max_value;
  max_value         = max_value + k_PHASE_INTERVAL;
end
return;