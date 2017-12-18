function  [outFilterCoeffs] = extract_filter_left(inFilterCoeffs, minLevelDB)
%
% function  [outFilterCoeffs] = extract_filter_left(inFilterCoeffs, minLevelDB)
%
% Returns the FIR filter center, discarding taps on the left whose value is < minLevelDB
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
% We assume that the taps on the left are relevant, taps on right decay to zero
%
%
maxTap		= max(inFilterCoeffs);
minTap		= maxTap * 10.^(minLevelDB/20);
inputLength	= length(inFilterCoeffs);
minIndex	= inputLength;
for i=linspace(inputLength,1,inputLength)
  if(inFilterCoeffs(i) > minTap)
    break;
  end
  minIndex	= i;
end
%
% Now, extract the left side of the input filter coefficients:
%
index		= 1:minIndex;
outFilterCoeffs	= inFilterCoeffs(index);

return;