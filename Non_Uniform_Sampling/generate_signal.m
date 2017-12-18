function signal = generate_signal(times, omegas, phases)
% **********************************************************************
% function generate_signal(times, phase)
%
% Generates a two sine wave signal at the given input times (usually non-uniformly spaced)
%
% Description:
% -----------
% Generate signal
%
% Input variables:
% -----------------------
%  times        : sample times
%  omegas       : vector of frequencies
%  phases       : vector of phase offsets
%
% Output variables:
% -----------------------
%  signal       : Output signal
%
% Notes:
% ----------
% None
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% None
%
% Revision History
% ----------------
%  - April 6, 2013 - Started
% *************************************************************************
%
%
% Initialize output vector
%
signal  = zeros(1, length(times));
% Loop over the number of phases
%
for i=1:length(phases)
  signal    = signal + sin(omegas(i)*times + phases(i));
end
return;
