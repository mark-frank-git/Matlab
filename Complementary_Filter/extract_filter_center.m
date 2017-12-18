function  [outFilterCoeffs] = extract_filter_center(inFilterCoeffs, minLevelDB)
%
% function  [outFilterCoeffs] = extract_filter_center(inFilterCoeffs, minLevelDB)
%
% Returns the FIR filter center, discarding taps whose value is < minLevelDB
%
% Description:
% ------------
%  Returns the relevant filter coefficients
%
% Input variables:
% ----------------
%  inFilterCoeffs	: input filter taps
%  minLevelDB		: Min tap level relative to max tap to keep
%
% Output variables:
% -----------------
%  outFilterCoeffs	: output filter coefficients
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
% We assume the maximum filter tap is somewhere near the center, and then
% search for the minimum tap > minLevelDB from the left (start)
%
%
maxTap		= max(inFilterCoeffs);
minTap		= maxTap * 10.^(minLevelDB/20);
minIndex	= 1;
inputLength	= length(inFilterCoeffs);
for i=1: inputLength
  if(inFilterCoeffs(i) > minTap)
    break;
  end
  minIndex	= i;
end
%
% Now, extract the center of the input filter coefficients:
%
index		= minIndex:1:inputLength-minIndex+1;
outFilterCoeffs	= inFilterCoeffs(index);

return;