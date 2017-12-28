function filteredSignal = affineProjectionFilter(frameSize, regressor, signalPlusInterferer)
% **********************************************************************
% function filteredSignal = affineProjectionFilter(frameSize, regressor, signalPlusInterferer)
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
% 1. K. Ozeki, T. Umeda, “An adaptive Filtering Algorithm Using an Orthogonal Projection to an Affine Subspace and its Properties”,
%    Electron. Commun. Jpn. 67-A(5), May 1984, pp. 19–27.
% 2. Paulo S. R. Diniz, Adaptive Filtering: Algorithms and Practical Implementation, Second Edition. Boston: Kluwer Academic
%    Publishers, 2002
% *************************************************************************
% Construct the affine projection filter
% method: 'Direct Matrix Inversion' |'Recursive Matrix Update' |' Block Direct Matrix Inversion'
echoCanceller    = dsp.AffineProjectionFilter  (...
                    'Method',           'Direct Matrix Inversion', ...
                    'Length',           frameSize, ...
                    'ProjectionOrder',  2, ...
                    'StepSize',         0.5, ...
                    'InitialCoefficients',            0.0, ...
                    'InitialOffsetCovariance',        1);

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
