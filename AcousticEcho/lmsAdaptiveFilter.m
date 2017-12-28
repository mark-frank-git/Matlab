function filteredSignal = lmsAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
% **********************************************************************
% function filteredSignal = lmsAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
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
% 1. Adaptive Signal Processing edited by Bernard Widrow and Samuel D. Stearns
% *************************************************************************
% Construct the LMS Adaptive Filter
% method: 'LMS' |'Normalized LMS' |'Sign-Error LMS' | 'Sign-Data LMS' | 'Sign-Sign LMS'
filterTaps       = frameSize;
echoCanceller    = dsp.LMSFilter (...
                    'Method',                    'LMS', ...
                    'Length',                    filterTaps, ...
                    'StepSizeSource',            'Property', ...
                    'StepSize',                  0.2, ...
                    'LeakageFactor',             1.0, ...
                    'InitialConditions',         0.0, ...
                    'AdaptInputPort',            0, ...
                    'WeightsResetInputPort',     0, ...
                    'WeightsOutput',            'None');

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
