function filteredSignal = rlsAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
% **********************************************************************
% function filteredSignal = rlsAdaptiveFilter(frameSize, regressor, signalPlusInterferer)
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
% 1. M Hayes, Statistical Digital Signal Processing and Modeling, New York: Wiley, 1996
% 2. S. Haykin, Adaptive Filter Theory, 4th Edition, Upper Saddle River, NJ: Prentice Hall, 2002
% 3. A.A. Rontogiannis and S. Theodoridis, "Inverse factorization adaptive least-squares algorithms," Signal Processing, vol. 52, no. 1, pp. 35-47, July 1996.
% 4. S.C. Douglas, "Numerically-robust O(N2) RLS algorithms using least-squares prewhitening," Proc. IEEE Int. Conf. on Acoustics, Speech, and Signal Processing, Istanbul, Turkey, vol. I, pp. 412-415, June 2000.
% 5. A. H. Sayed, Fundamentals of Adaptive Filtering, Hoboken, NJ: John Wiley & Sons, 2003 
% *************************************************************************
% Construct the RLS Adaptive Filter
% method: 'Conventional RLS' | 'Householder RLS' | 'Sliding-window RLS' | 'Householder sliding-window RLS' | 'QR decomposition' The default value is Conventional RLS
numberTaps       = 1000;
echoCanceller    = dsp.RLSFilter(...
                    'Method',           'Conventional RLS', ...
                    'Length',           numberTaps, ...
                    'ForgettingFactor', 1.0);

% Truncate the signals to an integer number of frames
numberFrames        = floor(length(regressor)/frameSize);
truncatedSize       = numberFrames*frameSize;
[y, filteredSignal] = echoCanceller(regressor(1:truncatedSize), signalPlusInterferer(1:truncatedSize));
