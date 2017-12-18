function [xpts ypts] = find_new_points(iq_angles, index, iq_real, iq_imag)
% **********************************************************************
% function find_new_points(iq_angles, index, iq_real, iq_imag)
%
% Finds 3 new points spread out around the circle
%
% Description:
% -----------
% Find new points
%
% Input variables:
% -----------------------
%  iq_angles        : array of angles on the circle
%  index            : index to start looking 
%  iq_real          : array of x points corresponding to angles
%  iq_imag          : array of y points corresponding to angles
%
% Output variables:
% -----------------------
%  xpts             : 3 x-points on circle
%  ypts             : 3 y-points on circle
%
% Calls:
% -----------
%  findNewAngle
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
% Initialize parameters
%
kMIN_ANGLE_DISTANCE = pi/3.;
firstIndex          = index;
firstAngle          = iq_angles(index);
%
% Find second index
%
[secondAngle secondIndex]   = findNewAngle(iq_angles, firstAngle, index, kMIN_ANGLE_DISTANCE);
if (secondAngle < -50.)
  index                     = 1;
  [secondAngle secondIndex] = findNewAngle(iq_angles, firstAngle, index, kMIN_ANGLE_DISTANCE);
end;
%
% Find third index
%
[thirdAngle thirdIndex]     = findNewAngle(iq_angles, secondAngle, secondIndex, kMIN_ANGLE_DISTANCE);
if (thirdAngle < -50.)
  index                     = 1;
  [thirdAngle thirdIndex]   = findNewAngle(iq_angles, secondAngle, index,       kMIN_ANGLE_DISTANCE);
end;
%
% Fill in the points
%
xpts(1)             = iq_real(firstIndex);
xpts(2)             = iq_real(secondIndex);
xpts(3)             = iq_real(thirdIndex);
%
ypts(1)             = iq_imag(firstIndex);
ypts(2)             = iq_imag(secondIndex);
ypts(3)             = iq_imag(thirdIndex);
% Debugging
angle1              = atan2(ypts(1), xpts(1));
angle2              = atan2(ypts(2), xpts(2));
angle3              = atan2(ypts(3), xpts(3));

return;

function [newAngle newIndex] = findNewAngle(iq_angles, oldAngle, minIndex, minAngleDistance)
% **********************************************************************
% function findNewAngle(iq_angles, oldAngle, minIndex, minAngleDistance)
%
% Finds a new angle that is greater than minAngleDistance from old angle
%
% Description:
% -----------
% Find new angle and distance
%
% Input variables:
% -----------------------
%  iq_angles        : array of angles on the circle
%  oldAngle         : old angle to check min distance
%  minIndex         : Min index to search
%  minAngleDistance : min angle distance spacing between angles
%
% Output variables:
% -----------------------
%  newAngle         : New angle found in radians
%  newIndex         : index of new angle
%
% References:
% -----------
% Newton Raphson solution of non-linear equations
%
% Revision History
% ----------------
%  - Jan. 8, 2013 - Started
% *************************************************************************
newAngle            = -100;
newIndex            = minIndex;
for i=minIndex:length(iq_angles)
  angle             = iq_angles(i);
  if(abs(angle-oldAngle)>minAngleDistance && (abs(angle+oldAngle) > minAngleDistance))
    newIndex        = i;
    newAngle        = angle;
    break;
  end;
end;
