function filteredSignal = latticeAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
% **********************************************************************
% function filteredSignal = freqDomainAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
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
% 1. https://www.mathworks.com/help/dsp/ref/dsp.frequencydomainadaptivefilter-system-object.html
% 2. Griffiths, Lloyd J. “A Continuously Adaptive Filter Implemented as a Lattice Structure”. Proceedings of IEEE Int. Conf. on
%    Acoustics, Speech, and Signal Processing, Hartford, CT, pp. 683–686, 1977 .
% 3. Haykin, S. Adaptive Filter Theory, 4th Ed. Upper Saddle River, NJ: Prentice Hall, 1996.
% *************************************************************************
% Construct the Lattice Adaptive Filter
% as one of 'Least-squares Lattice' |'QR-decomposition Least-squares Lattice' |'Gradient Adaptive Lattice'
method           = 'Gradient Adaptive Lattice';
filterTaps       = frameSize;
echoCanceller    = dsp.AdaptiveLatticeFilter(...
                    'Method',           method, ...
                    'Length',           filterTaps, ...
                    'StepSize',         0.2);

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
