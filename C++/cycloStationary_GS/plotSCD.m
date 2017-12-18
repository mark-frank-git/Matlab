function  plotSCD()
%
% function  S = plotSCD(data, fs, N, L, scdType)
%
% plotSCD plots and returns the spectral correlation density function for
% an input array.
%
% Description:
% -----------
%  Returns the spectral correlation density function
%
% Input variables:
% ----------------
%  data			: Complex input data array
%  fs			: Sampling frequency in Hertz
%  N			: Size of FFT blocks (should be a power of 2)
%  L			: Decimation factor (N/4 is a good value).
%  scdType		: 1 = use FFT accumulation method, 2 = use 
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
% fft_accumulation_method <or> dfsm_pace: calculates the SCD
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
DFSM			= 1;
FAM				= 2;
data			= ones(1024);
fs			= 1;
N			= 64;
L			= 4;
scdType			= DFSM;
%
% Find the SCD
%
switch scdType
	case DFSM
		[S freq alpha]	= dfsm_pace(data, fs, N, L);
	case FAM
		S				= fft_accumulation_method(data, data, N, 'blackman', 'blackman', L);
		S				= circshift(S, -2);
		S				= circshift(S',-1)';
%
% Find the frequency and alpha matrices
%
		[rows cols]		= size(S);
		freq			= fs*(1:rows)/rows - fs/2;
		alpha			= 2*fs*(1:cols)/cols - fs;
end
%
% Plot it:
%
S				= abs(S);
S				= S./max(max(S));
contour(alpha, freq, S);
grid;
xlabel('Cycle frequency (Hz)'); ylabel('Frequency (Hz)');
title (['FAM  ', ', N = ', int2str(N)]);
colorbar;
size(S)
