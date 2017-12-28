function timeScope = setupTimeScope(fs, speechLength, titles)
% **********************************************************************
% function timeScope = setupTimeScope(fs, speechLength, titles)
%
% Sets up and returns time scope for displaying multiple speech signals
%
% Description:
% -----------
% set up time scope
%
% Input variables:
% -----------------------
% fs                    = sampling rate in Hz
% speechLength          = length of speech signals
% titles                = array of titles
%
% Output variables:
% -----------------------
%  timeScope            = time scope for displaying speech signals
%
% Revision History
% ----------------
%  - Dec. 23d, 2017 - Started
%
% References
% -----------------------
% 1. http://www.mathworks.com/help/audio/examples/acoustic-echo-cancellation-aec.html?s_tid=gn_loc_drop
% *************************************************************************
numberDisplays  = length(titles);
timeSpan        = 35; %should pass this in
timeScope       = dsp.TimeScope(numberDisplays,          fs, ...
                                'LayoutDimensions',      [numberDisplays, 1], ...
                                'TimeSpan',              timeSpan, ...
                                'TimeSpanOverrunAction', 'Scroll', ...
                                'BufferLength',          speechLength);
for i=1:numberDisplays
  timeScope.ActiveDisplay = i;
  timeScope.ShowGrid      = true;
  timeScope.YLimits       = [-1.5 1.5];
  timeScope.Title         = titles(i);
end
