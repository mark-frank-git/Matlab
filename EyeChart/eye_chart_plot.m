function eye_chart_plot(traceData, samplesPerSymbol, fSample, figureTitle)
%function eye_chart_plot(traceData, samplesPerSymbol, fSample, figureTitle)
%
%
% Description:
% ------------
%  Plots an eye chart for the input trace data
%
% Input variables:
% ----------------
%  traceData        : column vector of trace time data
%  samplesPerSymbol : # of samples/symbol
%  fSample          : Sampling frequency in Hertz
%  figureTitle      : Title for chart
%
% Output variables:
% -----------------
% None
%
%
% Revision History
% ----------------
%  - March 19, 2015 - Started.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the figure
t       = 0:length(traceData)-1;
hFig    = figure;
plot(t, traceData);
title(figureTitle);
xlabel('Time (sec)');
ylabel('Amplitude');
grid on

% manage the figures
managescattereyefig(hFig);

% Create an eye diagram object
eyeObj = commscope.eyediagram(...
    'SamplingFrequency', fSample, ...
    'SamplesPerSymbol', samplesPerSymbol, ...
    'PlotTimeOffset', 4.45e9)

% Update the eye diagram object with the transmitted signal
update(eyeObj, 0.5*traceData);
title(figureTitle);
ylabel('Amplitude');
% Manage the figures
managescattereyefig(hFig, eyeObj, 'right');