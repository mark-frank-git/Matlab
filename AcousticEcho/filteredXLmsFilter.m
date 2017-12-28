function filteredSignal = filteredXLmsFilter(frameSize, regressor, signalPlusInterferer)
% **********************************************************************
% function filteredSignal = filteredXLmsFilter(frameSize, regressor, signalPlusInterferer)
%
% Attempts to remove the interferer (e.g., echo) from the input signal plus interferer
%
% Description:
% -----------
% adaptive filter
%
% Input variables:
% -----------------------
% frameSize             = size in samples
% regressor             = e.g., the far end speech in an echo canceller
% signalPlusInterferer  = signal to get cleaned up
%
% Output variables:
% -----------------------
%  filteredSignal       = Filtered signal (e.g., minus the echo)
%
% Revision History
% ----------------
%  - Dec. 15, 2017 - Started
%
% References
% -----------------------
% 1.  Kuo, S.M. and Morgan, D.R. Active Noise Control Systems: Algorithms and DSP Implementations. New York: John Wiley & Sons, 1996.
% 2.  Widrow, B. and Stearns, S.D. Adaptive Signal Processing. Upper Saddle River, N.J: Prentice Hall, 1985
% *************************************************************************
% Construct the filtered XLMS filter
filterTaps       = frameSize;
echoCanceller    = dsp.FilteredXLMSFilter  (...
                    'Length',           filterTaps, ...
                    'StepSize',         0.06, ...
                    'LeakageFactor',    1);

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
