function filteredSignal = freqDomainAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
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
% 2. Shynk, J.J.“Frequency-Domain and Multirate Adaptive Filtering.” IEEE Signal Processing Magazine,
%    Vol. 9, No. 1, pp. 14–37, Jan. 1992.
% *************************************************************************
% Construct the Lattice Adaptive Filter
% as one of 'Least-squares Lattice' |'QR-decomposition Least-squares Lattice' |'Gradient Adaptive Lattice'
method           = 'Unconstrained FDAF';
filterTaps       = frameSize;
echoCanceller    = dsp.FrequencyDomainAdaptiveFilter(...
                    'Length',          filterTaps, ...
                    'StepSize',        0.025, ...
                    'InitialPower',    0.01, ...
                    'AveragingFactor', 0.98, ...
                    'Method',          method);

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
