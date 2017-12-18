% Description:
% ------------
%  Main routine for plotting eye chart
%
% Calls:
% ----------
% eye_chart_plot
%
% Revision History
% ----------------
%  - March 19, 2015 - Started.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sets some constants
samplesPerSymbol= 100;
fSample         = 100e6;

% Read in the data from the EyeUnitTest project
fileID          = fopen('test_eye_output.txt', 'r');
formatSpec      = '%f';
traceData       = fscanf(fileID, formatSpec);

% call the eye chart plotting function
title           = 'Eye Chart';
eye_chart_plot(traceData, samplesPerSymbol, fSample, title);
