function  S = plotSCDFor(signalType, codeType, scdType, fs, N, L)
%
% function  S = plotSCDFor(signalType, codeType, scdType, fs, N, L)
%
% plotSCD plots and returns the spectral correlation density function for
% a given signal type.
%
% Description:
% -----------
%  Plots and returns the spectral correlation density function
%
% Input variables:
% ----------------
%  signalType	: Type of signal (see below).
%  codeType		: Polyphase code type
%  scdType		: Type of method to compute SCD (see below).
%  fs			: Sampling frequency in Hertz
%  N			: Size of FFT blocks (should be a power of 2)
%  L			: Decimation factor (N/4 is a good value).
%
% Output variables:
% ----------------
%  S			: Spectral correlation density function
%
% Notations:
% ----------
%
% Calls:
% -----------
% fft_accumulation_method <or> dfsm_pace: Calculates the SCD
%
% References:
% -----------
%  [PAC04]:P.E. Pace, Detecting and Classifying Low Probability of
%  Intercept Radar, Artech House, 2004.
%
% Revision History
% ----------------
%  - July 14, 2005 - Started.
% *****************************************************************************
%
NUMBER_POINTS		= N;
SNR					= 20;
FREQUENCY_1			= fs/3;
FREQUENCY_2			= fs/6;
CODE_LENGTH			= 16;
SAMPLES_PER_BIT		= 3;
PRI					= 60;
Np					= 64;
M					= 8;
%
% Define signal types:
%
SINGLE_REAL_SINE	= 1;
SINGLE_COMPLEX_SINE	= 2;
DOUBLE_REAL_SINE	= 3;
DOUBLE_COMPLEX_SINE	= 4;
POLYPHASE_CODE		= 5;
%
% Get the signal
%
switch signalType
	case SINGLE_REAL_SINE
		data	= real(sine_wave_plus_noise(SNR, FREQUENCY_1, fs, NUMBER_POINTS));
	case SINGLE_COMPLEX_SINE
		data	= sine_wave_plus_noise(SNR, FREQUENCY_1, fs, NUMBER_POINTS);
	case DOUBLE_REAL_SINE
		data	= real(sine_wave_plus_noise(SNR, FREQUENCY_1, fs, NUMBER_POINTS));
		data	= data + real(sine_wave_plus_noise(SNR, FREQUENCY_2, fs, NUMBER_POINTS));
	case DOUBLE_COMPLEX_SINE
		data	= sine_wave_plus_noise(SNR, FREQUENCY_1, fs, NUMBER_POINTS);
		data	= data + sine_wave_plus_noise(SNR, FREQUENCY_2, fs, NUMBER_POINTS);
	case POLYPHASE_CODE
		data	= radar_waveform(codeType, CODE_LENGTH, SAMPLES_PER_BIT, PRI, NUMBER_POINTS, fs, SNR, FREQUENCY_2);
end
%
% Find the SCD
%
S			= plotSCD(data, fs, N, L, Np, M, scdType);
clear data;