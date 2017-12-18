function impulseResponse = room_impulse_response(fs, frameSize)
% **********************************************************************
% function impulseResponse = room_impulse_response(fs, frameSize)
%
% Returns the simulated room impulse response using a chebyshev filter
%
% Description:
% -----------
% Room impulse response
%
% Input variables:
% -----------------------
% fs = sample rate in Hz
% frameSize = size in samples
%
% Output variables:
% -----------------------
%  impulseResponse  = Impulse response of room
%
% Revision History
% ----------------
%  - Dec. 15, 2017 - Started
% *************************************************************************
M     = fs/2 + 1;
[B,A] = cheby2(4,20,[0.1 0.7]);
impulseResponseGenerator = dsp.IIRFilter('Numerator', [zeros(1,6) B], ...
    'Denominator', A);

FVT = fvtool(impulseResponseGenerator);  % Analyze the filter
FVT.Color = [1 1 1];

impulseResponse = impulseResponseGenerator( ...
        (log(0.99*rand(1,M)+0.01).*sign(randn(1,M)).*exp(-0.002*(1:M)))');
impulseResponse = impulseResponse/norm(impulseResponse)*4;

plotImpulse = 0;
if(plotImpulse) then
  fig = figure;
  plot(0:1/fs:0.5, impulseResponse);
  xlabel('Time (s)');
  ylabel('Amplitude');
  title('Room Impulse Response');
  fig.Color = [1 1 1];
end