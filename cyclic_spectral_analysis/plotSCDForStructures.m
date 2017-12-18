function  plotSCDForStructures(waveformStructure, scdStructure)
%
% function  plotSCDFor(waveformStructure, scdStructure)
%
% plotSCD plots and returns the spectral correlation density function for
% a given set of signal parameters and SCD parameters.
%
% Description:
% -----------
%  Plots the spectral correlation density function
%
% Input variables:
% ----------------
%  waveformStructure	: structure of waveform parameters
%  scdStructure			: structure of SCD parameters
%
% Output variables:
% ----------------
%  None
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
% Define signal types:
%
SINGLE_REAL_SINE	= 1;
SINGLE_COMPLEX_SINE	= 2;
DOUBLE_REAL_SINE	= 3;
DOUBLE_COMPLEX_SINE	= 4;
POLYPHASE_CODE		= 5;
%
% Get variables from structures:
%
fs					= waveformStructure.fs;
number_points		= waveformStructure.numberSamples;
snr					= waveformStructure.snr;
frequency1			= waveformStructure.frequency1;
frequency2			= waveformStructure.frequency2;
code_length			= waveformStructure.codeLength;
samples_per_bit		= waveformStructure.samplesPerChip;
pri					= waveformStructure.pri;
signal_type			= waveformStructure.signalType;
code_type			= waveformStructure.codeType;

scd_type			= scdStructure.scdType;
L					= scdStructure.overlapSize;
M					= scdStructure.M;
Np					= scdStructure.Np;
%
% Generate the signal
%
switch signal_type
	case SINGLE_REAL_SINE
		data	= real(sine_wave_plus_noise(snr, frequency1, fs, number_points));
	case SINGLE_COMPLEX_SINE
		data	= sine_wave_plus_noise(snr, frequency1, fs, number_points);
	case DOUBLE_REAL_SINE
		data	= real(sine_wave_plus_noise(snr, frequency1, fs, number_points));
		data	= data + real(sine_wave_plus_noise(snr, frequency2, fs, number_points));
	case DOUBLE_COMPLEX_SINE
		data	= sine_wave_plus_noise(snr, frequency1, fs, number_points);
		data	= data + sine_wave_plus_noise(snr, frequency2, fs, number_points);
	case POLYPHASE_CODE
		data	= radar_waveform(code_type, code_length, samples_per_bit, pri, number_points, fs, snr, frequency2);
end
%
% Find the SCD
%
S			= plotSCD(data, fs, number_points, L, Np, M, scd_type);
clear	S;
clear	data;