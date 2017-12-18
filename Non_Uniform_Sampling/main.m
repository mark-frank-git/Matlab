function  main()
% **********************************************************************
% function main()
%
% Main program for non-uniform sampling with "DFT"
%
% Description:
% -----------
% Main driver
%
% Input variables:
% -----------------------
%  None
%
% Output variables:
% -----------------------
%  None
%
% Notations:
% ----------
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
% Set up
%
number_points_per_segment   = 32;
number_segments             = 16;
max_gap                     = 5;
max_rate_change             = 0.5;
range                       = 1;               % random time range = range*[-0.5, 0.5]
%
% Generate non-uniform times, with number_segments different sample rates
%
times                       = generate_sample_times(number_points_per_segment, number_segments, max_gap, max_rate_change, range);
%
% Plot times
%
figure(1), clf, hold all
linear_times    = 0:length(times)-1;
p               = plot([times';linear_times], linear_times);
grid on, zoom on
ylabel('Non-uniform times');
xlabel('Sample');
title(['Non-uniform Sampling']);
set(p,'Color','red','LineWidth',2)
%
% Generate two sine waves at the non-uniform sample times
omegas          = [1.2, 3.3];       % frequencies
phases          = [0.7, 0.2];       % phases
signal          = generate_signal(times', omegas, phases);
%
% Plot FFT
%
figure(2), clf, hold all
p   = plot(abs(fft(signal)));
grid on, zoom on
ylabel('Magnitude');
xlabel('Frequency');
title(['FFT Output']);
set(p,'Color','red','LineWidth',2)
%
% Generate "DFT" matrix
%
f_matrix        = generate_fourier_matrix(times);
%
% Multiply DFT by signal
%
dft_output      = f_matrix * signal';
%
% Plot "DFT" Output
%
figure(3), clf, hold all
grid on, zoom on
ylabel('Magnitude');
xlabel('Frequency');
title(['DFT Output']);
p   = plot(abs(dft_output));
set(p,'Color','blue','LineWidth',2)
